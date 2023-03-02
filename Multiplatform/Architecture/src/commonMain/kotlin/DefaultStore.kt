package Multiplatform.Architecture

class DefaultStore<State, in Action, in Effect>(
    private var state: State,
    private val onStateChange: (State) -> Unit,
    private val reducer: Reducer<State, Action, Effect>,
    private val effectHandler: EffectHandler<State, Action, Effect>
) : Store<State, Action> {
    override fun dispatch(action: Action) {
        println("DefaultStore: dispatch($action)")
        val (newState, effect) = reducer.reduce(state, action)
        println("DefaultStore: will set state($newState)")
        state = newState
        println("DefaultStore: onStateChange($newState)")
        onStateChange(newState)
        println("DefaultStore: effectHandler.handle($effect)")
        effectHandler.handle(effect, this)
    }
}