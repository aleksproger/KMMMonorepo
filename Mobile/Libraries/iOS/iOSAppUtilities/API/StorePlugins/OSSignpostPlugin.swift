import iOSArchitectureAPI
import Foundation
import os.signpost

public final class OSSignpostPlugin<S, A, E>: StorePlugin {
  public typealias State = S
  public typealias Action = A
  public typealias Effect = E
  
  private let signposter = OSSignposter(
    subsystem: Bundle.main.bundleIdentifier ?? "kmm.foundation",
    category: "architecture.store"
)
  
  private var signposts: [Signpost] = []
  
  public init() {}
  
  public func onWillDispatch(action: A, state: S) {
    let id = signposter.makeSignpostID()
    let signpost = Signpost(
      id: id,
      state: signposter.beginInterval("dispatch(action:)", id: id, "Action: \(String(reflecting: action)) to store.\nState: \(String(reflecting: state))")
    )
    signposts.append(signpost)
  }
  
  public func onDidDispatch(action: A, state: S) {
    guard let signpost = signposts.popLast() else {
      fatalError("No signpost to end")
    }
    
    signposter.endInterval("dispatch(action:)", signpost.state, "End.\nState: \(String(reflecting: state))")
  }
  
  public func onWillReduce(action: A, state: S) {
    let id = signposter.makeSignpostID()
    let signpost = Signpost(
      id: id,
      state: signposter.beginInterval("reduce(action:state:)", id: id, "Action: \(String(reflecting: action)) to store.\nState: \(String(reflecting: state))")
    )
    signposts.append(signpost)
  }
  
  public func onDidReduce(action: A, state: S) {
    guard let signpost = signposts.popLast() else {
      fatalError("No signpost to end")
    }
    
    signposter.endInterval("reduce(action:state:)", signpost.state, "End.\nState: \(String(reflecting: state))")
  }
  
  public func onWillHandleEffect(effect: E) {
    let id = signposter.makeSignpostID()
    let signpost = Signpost(
      id: id,
      state: signposter.beginInterval("handle(effect:)", id: id, "Effect: \(String(reflecting: effect)).")
    )
    signposts.append(signpost)
  }
  
  public func onDidHandleEffect(effect: E) {
    guard let signpost = signposts.popLast() else {
      fatalError("No signpost to end")
    }
    
    signposter.endInterval("handle(effect:)", signpost.state, "Effect: \(String(reflecting: effect)).")
  }
}

private struct Signpost {
  let id: OSSignpostID
  let state: OSSignpostIntervalState
  
  init(
    id: OSSignpostID,
    state: OSSignpostIntervalState
  ) {
    self.id = id
    self.state = state
  }
}
