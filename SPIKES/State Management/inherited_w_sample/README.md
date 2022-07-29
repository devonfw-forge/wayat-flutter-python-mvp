# inherited_sample

This approach is useful when you want to communicate state changes in a widget tree, but only to communicate changes from parent to child widgets.

## PROS

* Compared to a more traditional way, it saves a lot of code, avoiding that each child widget has to pass the state instance of the parent widget to its child.
* Using InheritedModel saves notifying all widgets that are pending the change of state of a widget, they are only notified by states and not by widget.

## CONS
* They depend on the context in which the widgets are created. They can only watch for parent widget state changes