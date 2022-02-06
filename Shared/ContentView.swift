import SwiftUI

struct ContentView: View {
    
    @ObservedObject var janken = Janken()
    @State var playerHand = 0
    @State var computerHand = 0
    @State var text = "いずれかの手を押してね"
    @State var syouhai : [Int] = [0,0,1]
    @AppStorage("kati") var kati : Double = 50
    @State var make = 100
    @State var kekka = 0
    
    var body: some View {
        
        VStack {
            VStack{
                Text("勝利する確率は\(kati, specifier: "%.0f")/100です。")
                Slider(value: $kati,
                       in: 0...100,
                       step: 1,
                       minimumValueLabel: Text("0"),
                       maximumValueLabel: Text("100"),
                       label: { EmptyView() }
                )
                Button(action: {
                    print(janken.computerHand)
                    self.make = 100 - Int(kati)
                    print(kati)
                    print(make)
                    syouhai.removeAll()
                    for _ in (0 ..< make) {
                        syouhai.append(0)
                    }
                    for _ in (0 ..< Int(kati)) {
                        syouhai.append(1)
                    }
                    print(syouhai)
                    print("配列の個数：\(syouhai.count)")
                }) {
                    Text("設定値を計算＆代入")// ラベルとして表示するView
                }
            } // 上部のスライダー
            VStack{
                /** 相手の手 */
                if(janken.computerHand == 0) {
                    Image("gu")
                        .resizable()
                        .scaledToFit()
                }
                if(janken.computerHand == 1) {
                    Image("choki")
                        .resizable()
                        .scaledToFit()
                }
                if(janken.computerHand == 2) {
                    Image("pa")
                        .resizable()
                        .scaledToFit()
                }
                if(janken.computerHand == 3) {
                    Image("appicon")
                        .resizable()
                        .scaledToFit()
                }

            } //相手の手
            .frame(height: 400)
            Text(text)
                .font(.title)
            if janken.mode == .stop {
                HStack {
                    Button(action: {
                        kekka = syouhai.randomElement() ?? 0
                        if kekka == 0 {
                            print("未来の結果は負け\(kekka)")
                        } else {
                            print("未来の結果は勝ち\(kekka)")
                        }
                        janken.start()
                    }) {
                        Image("gu")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                    }
                    Button(action: {
                        kekka = syouhai.randomElement() ?? 0
                        if kekka == 0 {
                            print("未来の結果は負け\(kekka)")
                        } else {
                            print("未来の結果は勝ち\(kekka)")
                        }
                        janken.start()
                    }) {
                        Image("choki")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                    }
                    Button(action: {
                        kekka = syouhai.randomElement() ?? 0
                        if kekka == 0 {
                            print("未来の結果は負け\(kekka)")
                        } else {
                            print("未来の結果は勝ち\(kekka)")
                        }
                        janken.start()
                    }) {
                        Image("pa")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                    }
                }
            } // 停止中の自分の手　じゃんけんstartトリガー
            if janken.mode == .start {
                
                HStack {
                    Button(action: {
                        janken.stop()
                        self.playerHand = 0
                        let chooseTemp = chooseComputerHand(kekka: self.kekka, playerHand: self.playerHand)
                        self.text = chooseTemp.result
                        janken.computerHand = chooseTemp.computerHand
                    }) {
                        Image("gu")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                    }
                    Button(action: {
                        janken.stop()
                        self.playerHand = 1
                        let chooseTemp = chooseComputerHand(kekka: self.kekka, playerHand: self.playerHand)
                        self.text = chooseTemp.result
                        janken.computerHand = chooseTemp.computerHand
                    }) {
                        Image("choki")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                    }
                    Button(action: {
                        janken.stop()
                        self.playerHand = 2
                        let chooseTemp = chooseComputerHand(kekka: self.kekka, playerHand: self.playerHand)
                        self.text = chooseTemp.result
                        janken.computerHand = chooseTemp.computerHand
                    }) {
                        Image("pa")
                            .renderingMode(.original)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
        } //View全体
        .onAppear{
            self.make = 100 - Int(kati)
            print(kati)
            print(make)
            syouhai.removeAll()
            for _ in (0 ..< make) {
                syouhai.append(0)
            }
            for _ in (0 ..< Int(kati)) {
                syouhai.append(1)
            }
            print(syouhai)
        } //起動時に勝敗の設定値を配列に格納
    }
}

func chooseComputerHand(kekka:Int, playerHand:Int) -> (result: String, computerHand: Int) {

    var computerHand : Int = 0
    @ObservedObject var janken = Janken()
    _ = 0
    
    if kekka == 0 {
        if playerHand == 0 {
            let random = Int.random(in: 0..<2)
            if random == 0 {
                computerHand = 0
            } else {
                computerHand = 2
            }
        }
        if playerHand == 1 {
            let random = Int.random(in: 0..<2)
            if random == 0 {
                computerHand = 1
            } else {
                computerHand = 0
            }
        }
        if playerHand == 2 {
            let random = Int.random(in: 0..<2)
            if random == 0 {
                computerHand = 2
            } else {
                computerHand = 1
            }
        }
    }
    if kekka == 1 {
        if playerHand == 0 {
            let random = Int.random(in: 0..<2)
            if random == 0 {
                computerHand = 0
                print("playerHand1:\(playerHand),computerHand:\(computerHand)")
            } else {
                computerHand = 1
                print("playerHand2:\(playerHand),computerHand:\(computerHand)")
            }
        }
        if playerHand == 1 {
            let random = Int.random(in: 0..<2)
            if random == 0 {
                computerHand = 1
                print("playerHand3:\(playerHand),computerHand:\(computerHand)")
            } else {
                computerHand = 2
                print("playerHand4:\(playerHand),computerHand:\(computerHand)")
            }
        }
        if playerHand == 2 {
            let random = Int.random(in: 0..<2)
            if random == 0 {
                computerHand = 2
                print("playerHand5:\(playerHand),computerHand:\(computerHand)")
            } else {
                computerHand = 0
                print("playerHand6:\(playerHand),computerHand:\(computerHand)")
            }
        }
    }
    
    var result = ""
    let Temp:(Int,Int) = (playerHand, computerHand)
    
    switch Temp {
    case (0, 0), (1, 1),(2, 2) :
        result = "あいこ!!"
        print("playerHand7:\(playerHand),computerHand:\(computerHand)")
    case (0, 1),(1, 2),(2, 0) :
        result = "あなたの勝ち!!"
        print("playerHand8:\(playerHand),computerHand:\(computerHand)")
        
    case (0, 2),(1, 0),(2, 1) :
        result = "あなたの負け!!"
        print("playerHand9:\(playerHand),computerHand:\(computerHand)")
    default :
        result = "???"
    }
    return (result, computerHand)
}

class Janken:ObservableObject{
    
    enum JankenMode{
        case start
        case stop
    }
    
    @Published var mode:JankenMode = .stop
    @Published var computerHand = 0
    
    var timer = Timer()
    
    func start(){
        mode = .start
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true){ timer in
            
            if self.computerHand == 0 {
                self.computerHand = 1
            } else if self.computerHand == 1 {
                self.computerHand = 2
            } else {
                self.computerHand = 0
            }
        }
        RunLoop.current.add(timer, forMode: .common)
        
    }
    
    func stop(){
        timer.invalidate()
        mode = .stop
        print("janken内のcomputerHand:\(computerHand)")
    }
    
} // じゃんけんの高速スクロールを作成

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(syouhai:[])
//    }
//}
