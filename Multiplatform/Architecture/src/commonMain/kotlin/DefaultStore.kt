package Multiplatform.Architecture

open class DefaultStore<State, in Action, in Effect>(
    private var state: State,
    private val reducer: Reducer<State, Action, Effect>,
    private val effectHandler: EffectHandler<State, Action, Effect>
) : Store<State, Action> {
    override suspend fun dispatch(action: Action): State {
        println("DefaultStore: dispatch($action)")
        val (newState, effect) = reducer.reduce(state, action)

        println("DefaultStore: will set state ")
        state = newState

        
        println("DefaultStore: effectHandler.handle($effect)")
        effectHandler.handle(effect, this)

        return state
    }
}