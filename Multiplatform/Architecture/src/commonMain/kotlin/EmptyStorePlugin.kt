package Multiplatform.Architecture

class EmptyStorePlugin<State, in Action, in Effect> : StorePlugin<State, Action, Effect> {
    override fun onWillDispatch(action: Action, state: State) {}
    override fun onDidDispatch(action: Action, state: State) {}
    override fun onWillReduce(action: Action, state: State) {}
    override fun onDidReduce(action: Action, state: State) {}
    override fun onWillHandleEffect(effect: Effect) {}
    override fun onDidHandleEffect(effect: Effect) {}
}