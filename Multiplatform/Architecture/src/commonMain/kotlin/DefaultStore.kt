package Multiplatform.Architecture

open class DefaultStore<State, in Action, Effect>(
    private var state: State,
    private val reducer: Reducer<State, Action, Effect>,
    private val effectHandler: EffectHandler<State, Action, Effect>,
    private val plugin: StorePlugin<State, Action, Effect>
) : Store<State, Action, Effect> {
    override suspend fun dispatch(action: Action): State {
        plugin.onWillDispatch(action, state)
        plugin.onWillReduce(action, state)

        val (newState, effect) = reducer.reduce(state, action)
        state = newState

        plugin.onDidReduce(action, state)
        plugin.onWillHandleEffect(effect)

        effectHandler.handle(effect, this)

        plugin.onDidHandleEffect(effect)
        plugin.onDidDispatch(action, state)
        return state
    }
}