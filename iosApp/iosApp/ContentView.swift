import SwiftUI
import shared

struct ContentView: View {
    let greet = Greeting().greet()
    let mainViewModel : MainViewModel = MainViewModel()
    
    @State private var showSplash :Bool = true
    var body: some View {
        ZStack {
            Text(greet)
            if(showSplash) {
                VStack{
                    Text("허접한 스플래쉬")
                        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .center)
                }
                .frame(maxWidth: .infinity,maxHeight: .infinity)
                .background(.white)
                .onAppear{
                    mainViewModel.hideSplash(withDelay: Int64(4000))
                }
            }
        }
        .onAppear{
            mainViewModel.showSplash.collect(
                collector: Collector<Bool> { value in
                    showSplash = value
                }
            ) { error in
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
