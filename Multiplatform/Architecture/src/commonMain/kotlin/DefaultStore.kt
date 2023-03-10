package Multiplatform.Architecture

open class DefaultStore<State, in Action, in Effect>(
    private var state: State,
    private val reducer: Reducer<State, Action, Effect>,
    private val effectHandler: EffectHandler<State, Action, Effect>,
    private val plugin: StorePlugin<State, Action>
) : Store<State, Action> {
    override suspend fun dispatch(action: Action): State {
        // println("DefaultStore: dispatch($action)")
        plugin.onWillDispatch(action, state)

        val (newState, effect) = reducer.reduce(state, action)
        // println("DefaultStore: will set state ")
        state = newState
    
        // println("DefaultStore: effectHandler.handle($effect)")
        effectHandler.handle(effect, this)

        plugin.onDidDispatch(action, state)

        return state
    }
}

interface StorePlugin<State, in Action> {
    fun onWillDispatch(action: Action, state: State)
    fun onDidDispatch(action: Action, state: State)
}


class EmptyStorePlugin<State, in Action> : StorePlugin<State, Action> {
    override fun onWillDispatch(action: Action, state: State) {}
    override fun onDidDispatch(action: Action, state: State) {}
}