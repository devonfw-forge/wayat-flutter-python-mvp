	First of all, Fluro is the one of the most popular 
navigation package for today.

## PROS
- Simple route navigation
- Function handlers (map to a function instead of a route)
- Wildcard parameter matching
- Querystring parameter parsing
- Common transitions built-in
- Simple custom transition creation
- Null-safety

  We will be able to create smooth, user-friendly navigation 
experiences with ease. Plus, with common transitions built-in and the ability to easily create custom transitions, we’ll be well on our way to creating an app that looks and feels great.
Also, it provides Flutter developers with web-like routing capabilities.

## Example Project
There is a pretty sweet example project in the `example` folder.

## Getting started

First, we should define a new `FluroRouter` object by initializing it as such:

```dart app_component.dart
final router = FluroRouter();
```

It may be convenient for us to store the router globally/statically so that we can access the router in other areas in our application.

After instantiating the router, we will need to define our routes and our route handlers: 
              router.dart, route_handlers.dart

## Navigating

We can use `FluroRouter` with the `MaterialApp.onGenerateRoute` parameter
via `FluroRouter.generator`. To do so, pass the function reference to
the `onGenerate` parameter like: `onGenerateRoute: router.generator`.

We can then use `Navigator.push` and the flutter routing mechanism will match the routes
for us.

We can also manually push to a route ourrself. To do so:

```dart
router.navigateTo(context, "/users/1234", transition: TransitionType.fadeIn);
```

## Class arguments

Don't want to use strings for params? No worries.

After pushing a route with a custom `RouteSettings` we can use the `BuildContext.settings` extension to extract the settings. Typically this would be done in `Handler.handlerFunc` so we can pass `RouteSettings.arguments` to your screen widgets.

```dart
/// Push a route with custom RouteSettings if you don't want to use path params
FluroRouter.appRouter.navigateTo(
  context,
  'home',
  routeSettings: RouteSettings(
    arguments: MyArgumentsDataClass('foo!'),
  ),
);

/// Extract the arguments using [BuildContext.settings.arguments] or [BuildContext.arguments] for short
var homeHandler = Handler(
  handlerFunc: (context, params) {
    final args = context.settings.arguments as MyArgumentsDataClass;

    return HomeComponent(args);
  },
);
```
So, I think, that choosing Fluro routing package is most suitable for the requirements of our project, growing and scale it in future.

As you can see in code example, code is clean, struct and readable.
We may get access to route to any components from any part of our application.