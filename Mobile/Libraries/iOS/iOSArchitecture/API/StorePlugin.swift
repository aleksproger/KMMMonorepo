public protocol StorePlugin {
    associatedtype State
    associatedtype Action
    associatedtype Effect

    func onWillDispatch(action: Action, state: State)
    func onDidDispatch(action: Action, state: State)

    func onWillReduce(action: Action, state: State)
    func onDidReduce(action: Action, state: State)

    func onWillHandleEffect(effect: Effect)
    func onDidHandleEffect(effect: Effect)
}