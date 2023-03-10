package Multiplatform.Architecture

interface StorePlugin<State, in Action, in Effect> {
    fun onWillDispatch(action: Action, state: State)
    fun onDidDispatch(action: Action, state: State)

    fun onWillReduce(action: Action, state: State)
    fun onDidReduce(action: Action, state: State)

    fun onWillHandleEffect(effect: Effect)
    fun onDidHandleEffect(effect: Effect)
}