import SwiftUI
import shared

class MainViewModel : ObservableObject {
    private let base : BaseViewModel = BaseViewModel()
    
    @Published var showSplash :Bool = true
    
    init() {
        base.showSplash.collect(
            collector: Collector<Bool> { value in
                self.showSplash = value
            }
        ) { error in
        }
    }
    
    func hideSplash(withDelay: Int64) {
        base.hideSplash(withDelay: withDelay)
    }
}

struct ContentView: View {
    let greet = Greeting().greet()
    @StateObject var mainViewModel : MainViewModel = MainViewModel()
    
    var body: some View {
        ZStack {
            Text(greet)
            if(mainViewModel.showSplash) {
                VStack{
                    Text("허접한 스플래쉬")
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(.white)
                .onAppear{
                    mainViewModel.hideSplash(withDelay: 4000)
                }
            }
        }
    }
}

class Collector<T> : Kotlinx_coroutines_coreFlowCollector {
    let callback:(T) -> Void

    init(callback: @escaping (T) -> Void) {
        self.callback = callback
    }
    
    func emit(value: Any?, completionHandler: @escaping (Error?) -> Void) {
        callback(value as! T)
        completionHandler(nil)
    }
}
