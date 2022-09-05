# riverpod_sample

Riverpod is a library to manage app statement in a similar way to provider but with extra features.

## PROS
- Same maintainers, sponsors and github user owner:
    - https://github.com/rrousselGit/provider#sponsors
    - https://github.com/rrousselGit/riverpod#sponsors
- Compile-time safe (Provider raises runtime errors when accessing non-provide types).
- Improves readability with its simplicity.
- Two ways to use consumers anywhere:
    - Consumer: improves performance
    - ConsumerWidget improves readability.
- It doesn't depends on flutter-sdk.
- Allows nested providers.
- Easy to test (it's easy to add a logger to monitor the state).
- Auto-cached data and autodispose modifiers.
- Easy management of asynchronous request (data, load, error branches)

## CONS
- Developers must check all providers and notifiers to select the best fit.
- It inherits ChangeNotifierProvider from provider (which has a bad scalability, instead they recommends StateNotifierProvider, which state is unmutable)

