# MobX with GetIt

## PROS
* Great way to separate internal implementation details from the UI 
* With GetIt we can avoid adding and passing down parameters in the UI that do not relate to the UI itself
* State can be accessed from any component
* Does not need to add a lot of widgets to the widget tree, just wrap Observer on the elements that can be updated
* Unlike setState, when the state changes only the widgets inside Observer get updated


## CONS
* The increased resource usage from GetIt
