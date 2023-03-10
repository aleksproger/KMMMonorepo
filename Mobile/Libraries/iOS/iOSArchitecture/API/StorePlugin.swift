public protocol StorePlugin {
    associatedtype State
    associatedtype Action

    func onWillDispatch(action: Action, state: State)
    func onDidDispatch(action: Action, state: State)
}
