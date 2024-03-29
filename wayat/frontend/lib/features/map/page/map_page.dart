import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/app_state/location_state/location_listener.dart';
import 'package:wayat/common/theme/colors.dart';
import 'package:wayat/common/widgets/contact_image.dart';
import 'package:wayat/common/widgets/search_bar.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/domain/group/group.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/common/widgets/loading_widget.dart';
import 'package:wayat/features/groups/controllers/groups_controller/groups_controller.dart';
import 'package:wayat/features/map/controller/map_controller.dart';
import 'package:wayat/features/map/widgets/platform_map_widget/mobile_map_widget.dart';
import 'package:wayat/features/map/widgets/platform_map_widget/web_desktop_map_widget.dart';
import 'package:wayat/features/map/widgets/platform_map_widget/platform_map_widget.dart';
import 'package:wayat/features/map/widgets/contact_dialog.dart';
import 'package:wayat/features/map/widgets/contact_map_list_tile.dart';
import 'package:wayat/features/map/widgets/platform_marker_widget/platform_marker_widget.dart';
import 'package:wayat/features/map/widgets/suggestions_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';
import 'package:wayat/services/common/platform/platform_service_libw.dart';
import 'package:wayat/services/share_location/background_location_exception.dart';
import 'package:wayat/services/share_location/no_location_service_exception.dart';
import 'package:wayat/services/share_location/rejected_location_exception.dart';

/// Main page of wayat. Is the one displayed when the [BottomNavigationBar] is in wayat.
class MapPage extends StatelessWidget {
  /// Used to show the [Group] list below the search bar.
  final GroupsController controllerGroups = GetIt.I.get<GroupsController>();
  final LocationListener locationListener = GetIt.I.get<LocationListener>();
  final MapController controller;
  final PlatformService platformService;

  MapPage(
      {MapController? controller, PlatformService? platformService, Key? key})
      : controller = controller ?? MapController(),
        platformService = platformService ?? PlatformService(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    controllerGroups.updateGroups();
    controller.setOnMarkerPressed(
        (contact, icon) => showContactDialog(contact, icon, context));

    return FutureBuilder(
        future: initializeLocationState(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
                onTap: () {
                  removeFocusFromSearchBar(context);
                },
                child: Stack(
                  children: [
                    _mapLayer(),
                    if (!platformService.isDesktopOrWeb &&
                        !platformService.wideUi)
                      _draggableSheetLayer()
                  ],
                ));
          } else {
            return const LoadingWidget();
          }
        });
  }

  void removeFocusFromSearchBar(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  /// Initialize location state and check first if the location service
  /// is enabled correctly
  Future<void> initializeLocationState(context) async {
    while (true) {
      try {
        await locationListener.shareLocationState.initialize();
        await locationListener.initialize();
        return;
      } on NoLocationServiceException {
        await _showLocationPermissionDialog(context, true);
      } on RejectedLocationException {
        await _showLocationPermissionDialog(context);
      } on BackgroundLocationException {
        await _showLocationPermissionDialog(context);
      } on PlatformException {
        await _showLocationPermissionDialog(context);
      }
    }
  }

  /// Show permitions dialog to the user
  Future<void> _showLocationPermissionDialog(context,
      [serviceError = false]) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(appLocalizations.locationPermission),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(appLocalizations.locationPermissionNotGranted),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(appLocalizations.retry),
              onPressed: () async {
                Navigator.of(context).pop();
                // Open settings does not stop current app execution
                if (serviceError) {
                  // Open settings in location section
                  await AppSettings.openLocationSettings();
                } else {
                  // Open settings in the current app section
                  await AppSettings.openAppSettings();
                }
              },
            ),
            TextButton(
              child: Text(appLocalizations.cancel),
              onPressed: () {
                exit(0);
              },
            ),
          ],
        );
      },
    );
  }

  /// Return map widget with filtered markers
  Observer _mapLayer() {
    return Observer(builder: (context) {
      prepareMapData(context);
      Set<PlatformMarker> markers = controller.filteredMarkers;
      return Column(
        children: [
          searchBar(),
          const SizedBox(height: 5),
          groupsSlider(),
          const SizedBox(height: 5),
          Expanded(child: map(markers)),
        ],
      );
    });
  }

  void prepareMapData(BuildContext context) {
    List<ContactLocation> contacts =
        locationListener.receiveLocationState.contacts;
    if (contacts != controller.contacts) {
      controller.setContacts(contacts);
      controller.getMarkers();
    }
  }

  Widget searchBar() {
    return Autocomplete<ContactLocation>(
        displayStringForOption: (option) => option.name,
        optionsBuilder: (textEditingValue) {
          if (textEditingValue.text.isEmpty) {
            return const Iterable.empty();
          }
          return controller.contacts.where((contact) => contact.name
              .toLowerCase()
              .contains(textEditingValue.text.toLowerCase()));
        },
        onSelected: (ContactLocation contact) =>
            controller.onSuggestionsTap(contact),
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          return SearchBar(
            key: const Key("MapSearchBar"),
            controller: textEditingController,
            focusNode: focusNode,
            onChanged: (newText) => controller.setSearchBarText(newText),
          );
        },
        optionsViewBuilder: (context, onSelected, options) =>
            SuggestionsDialog(options: options, onSelected: onSelected));
  }

  Widget groupsSlider() {
    List<Group> groups = controllerGroups.groups;
    return (groups.isEmpty)
        ? Container()
        : SizedBox(
            key: const Key("groupSlider"),
            height: 70,
            width: double.infinity,
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                scrollDirection: Axis.horizontal,
                itemCount: groups.length,
                itemBuilder: ((context, index) {
                  final Group group = groups[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: SizedBox(
                      width: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.filterGroup(group);
                            },
                            child: ContactImage(
                              imageUrl: group.imageUrl,
                              radius: 25,
                              lineWidth: 3.0,
                              color: group == controller.selectedGroup
                                  ? ColorTheme.primaryColor
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            group.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                })),
          );
  }

  /// Google map with current user location coordinates
  Widget map(Set<PlatformMarker> markers) {
    PlatformMapWidget mapWidget = (platformService.isMobile)
        ? MobileMapWidget(markers: markers, controller: controller)
        : WebDesktopMapWidget(markers: markers, controller: controller);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (platformService.wideUi || platformService.isDesktopOrWeb)
          Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: AlignmentDirectional.topCenter,
                      end: AlignmentDirectional.bottomCenter,
                      colors: [
                    Colors.grey.shade100,
                    Colors.grey.shade50,
                  ])),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: 350,
              child: mapListView()),
        Expanded(child: mapWidget),
      ],
    );
  }

  /// Draggable layer with active sharing location contacts
  DraggableScrollableSheet _draggableSheetLayer() {
    return DraggableScrollableSheet(
        minChildSize: 0.13,
        initialChildSize: 0.13,
        builder: (context, scrollController) => Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: _bottomSheetScrollView(scrollController),
            ));
  }

  Widget _bottomSheetScrollView(ScrollController scrollController) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _scrollIndicator(),
            const SizedBox(
              height: 15,
            ),
            _sharingLocationButton(),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            const SizedBox(
              height: 10,
            ),
            mapListView()
          ],
        ),
      ),
    );
  }

  Widget mapListView() {
    return Observer(builder: (context) {
      List<ContactLocation> contacts =
          locationListener.receiveLocationState.contacts;
      return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: (index == 0)
                  ? const EdgeInsets.only(top: 20.0)
                  : (index == contacts.length - 1)
                      ? const EdgeInsets.only(bottom: 10.0)
                      : const EdgeInsets.all(0),
              child: ContactMapListTile(contact: contacts[index]),
            );
          },
          separatorBuilder: (_, __) => const Divider(
                color: Colors.black26,
              ),
          itemCount: contacts.length);
    });
  }

  Container _scrollIndicator() {
    return Container(
      height: 5,
      width: 60,
      decoration: const BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.all(Radius.circular(40))),
    );
  }

  /// Sharing location switch button
  Row _sharingLocationButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appLocalizations.sharingLocation,
          style: const TextStyle(
              fontWeight: FontWeight.w500, color: Colors.black87, fontSize: 18),
        ),
        Observer(builder: (context) {
          bool enabled =
              locationListener.shareLocationState.shareLocationEnabled;
          return CustomSwitch(
            value: enabled,
            onChanged: (newValue) {
              locationListener.shareLocationState
                  .setShareLocationEnabled(newValue);
            },
          );
        })
      ],
    );
  }

  /// Show contact dialog on Tap to the icon of the contact
  void showContactDialog(
      ContactLocation contact, BitmapDescriptor icon, BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return ContactDialog(
            contact: contact,
            icon: icon,
          );
        });
  }
}
