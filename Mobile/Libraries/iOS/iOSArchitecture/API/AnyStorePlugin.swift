public final class AnyStorePlugin<S, A, E>: StorePlugin {
    public typealias State = S
    public typealias Action = A
    public typealias Effect = E

    private let _onWillDispatch: (Action, State) -> Void
    private let _onDidDispatch: (Action, State) -> Void
    private let _onWillReduce: (Action, State) -> Void
    private let _onDidReduce: (Action, State) -> Void
    private let _onWillHandleEffect: (Effect) -> Void
    private let _onDidHandleEffect: (Effect) -> Void

    init<P: StorePlugin>(_ subject: P) 
    where P.State == State, P.Action == Action, P.Effect == Effect {
        self._onWillDispatch = subject.onWillDispatch
        self._onDidDispatch = subject.onDidDispatch
        self._onWillReduce = subject.onWillReduce
        self._onDidReduce = subject.onDidReduce
        self._onWillHandleEffect = subject.onWillHandleEffect
        self._onDidHandleEffect = subject.onDidHandleEffect
    }

    public func onWillDispatch(action: Action, state: State) {
        _onWillDispatch(action, state)
    }
    
    public func onDidDispatch(action: Action, state: State) {
        _onDidDispatch(action, state)
    }

    public func onWillReduce(action: Action, state: State) {
        _onWillReduce(action, state)
	}

    public func onDidReduce(action: Action, state: State) {
        _onDidReduce(action, state)
	}

    public func onWillHandleEffect(effect: Effect) {
        _onWillHandleEffect(effect)
	}

    public func onDidHandleEffect(effect: Effect) {
        _onDidHandleEffect(effect)
	}
}

extension StorePlugin {
    public func asAny() -> AnyStorePlugin<State, Action, Effect> {
        AnyStorePlugin(self)
    }
}
