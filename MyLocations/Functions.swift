import Foundation
import Dispatch

func afterDelay(_ seconds: Double, closure: () -> ()) {
  let when = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
  DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
}

let applicationDocumentsDirectory : String = {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    return paths[0]
}()
