import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wayat/app_state/location_state/location_state.dart';
import 'package:wayat/app_state/map_state/map_state.dart';
import 'package:wayat/app_state/user_status/user_status_state.dart';
import 'package:wayat/common/widgets/search_bar.dart';
import 'package:wayat/common/widgets/switch.dart';
import 'package:wayat/domain/location/contact_location.dart';
import 'package:wayat/common/widgets/loading_widget.dart';
import 'package:wayat/features/map/controller/map_controller.dart';
import 'package:wayat/features/map/widgets/contact_dialog.dart';
import 'package:wayat/features/map/widgets/contact_map_list_tile.dart';
import 'package:wayat/features/map/widgets/suggestions_dialog.dart';
import 'package:wayat/lang/app_localizations.dart';

class HomeMapPage extends StatelessWidget {
  final LocationState locationState = GetIt.I.get<LocationState>();
  final UserStatusState userStatusState = GetIt.I.get<UserStatusState>();
  final MapController controller;

  HomeMapPage({MapController? controller, Key? key})
      : controller = controller ?? MapController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    GetIt.I.get<MapState>().openMap();
    controller.setOnMarkerPressed(
        (contact, icon) => showContactDialog(contact, icon, context));

    return FutureBuilder(
        future: locationState.initialize(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [_mapLayer(), _draggableSheetLayer()],
            );
          } else {
            return const LoadingWidget();
          }
        });
  }

  Observer _mapLayer() {
    return Observer(builder: (context) {
      prepareMapData(context);
      Set<Marker> markers = controller.filteredMarkers;
      return Column(
        children: [
          searchBar(),
          const SizedBox(
            height: 10,
          ),
          Expanded(child: googleMap(markers)),
        ],
      );
    });
  }

  void prepareMapData(BuildContext context) {
    List<ContactLocation> contacts = userStatusState.contacts;
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
        onSelected: (contact) => controller.onSuggestionsTap(contact),
        fieldViewBuilder:
            (context, textEditingController, focusNode, onFieldSubmitted) {
          return SearchBar(
            controller: textEditingController,
            focusNode: focusNode,
            onChanged: (newText) => controller.setSearchBarText(newText),
          );
        },
        optionsViewBuilder: (context, onSelected, options) =>
            SuggestionsDialog(options: options, onSelected: onSelected));
  }

  GoogleMap googleMap(Set<Marker> markers) {
    LatLng currentLocation = LatLng(locationState.currentLocation.latitude,
        locationState.currentLocation.longitude);

    return GoogleMap(
      initialCameraPosition:
          CameraPosition(target: currentLocation, zoom: 14.5),
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      markers: markers,
      onMapCreated: (googleMapController) {
        controller.gMapController = googleMapController;
      },
    );
  }

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
      List<ContactLocation> contacts = userStatusState.contacts;
      return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) =>
              ContactMapListTile(contact: contacts[index]),
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
          bool enabled = locationState.shareLocationEnabled;
          return CustomSwitch(
            value: enabled,
            onChanged: (newValue) {
              locationState.setShareLocationEnabled(newValue);
            },
          );
        })
      ],
    );
  }

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
