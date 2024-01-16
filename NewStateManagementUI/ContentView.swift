/*
 Swiftdata
 
 - https://developer.apple.com/documentation/swiftdata incelenebilir
 - Swiftdata  ise siwftUI da coredatadan daha kolay daha basit uygulanmış halidir. Tabiki lokal veritabanıdır.ios 17 ve üssü geçerlidir
 - Proje açılırken swiftdata seçilmeyebilir sonradanda eklenebilir
 -bindable konusu için incelenebilir link https://www.donnywals.com/whats-the-difference-between-binding-and-bindable/
 
 //@Environment  yada @EnvironmentObject genel olarak çevresel değişkenler apin kendi değişkenleride olabilir
 */

import SwiftUI
import SwiftData


//---------------1.senaryo----------------
//parentView //ebeveyn görünüm
//struct ContentView: View {
//    //@State her değiştiğinde görünümde değişçektir anlamındadır
//    //State Management den gelen bir yapı değişiklikte arayüzde ne varsa değişikiğe uymasını sağalayan bir yapı
//    //normal butonda
//    @State var counter = 0
//    var body: some View {
//        VStack{
//            //buton ekledik
//            //            Button {
//            //                self.counter += 1
//            //            } label: {
//            //                    Text("Add")
//            //            }
//
//            //bu şekildede alınabilir
//            //binding değerler $ ilşe alınır
//            addButtonView(counter: $counter)
//            Text(String(counter))
//        }
//
//    }
//
//}
//
////buton için childView (çocuk görünüm)
//struct addButtonView : View {
//    //binding olucakki değer aktarılsın
//    //swiftdata burda binding yerine farklı bişey getircek hala swiftdata burda gerek yok
//    @Binding var counter : Int
//    //swiftData ile gelen kütüphanede biz @Bindable ile sınırlı gücü ile orservable sınıfları ile çalışır bir tık kontrolü ele alıyoruz
//    var body: some View {
//        Button {
//            self.counter += 1
//        } label: {
//            Text("Add")
//        }
//    }
//}
//#Preview {
//    ContentView()
//}#Preview {
//    ContentView()
//}







//---------------2.senaryo----------------
//class DarkTheme : Observable{ // yada
//Observable gözlemlenebilir sınıf
//@Observable
//class DarkTheme {
//    var isEnable : Bool = false
//}
//
////childView
//struct DarkChoiceView : View {
//    @Bindable var darkTheme : DarkTheme
//
//    var body: some View {
//        //toggle on olduğunda isEnable true olur diğeri false
//        Toggle(isOn: $darkTheme.isEnable) {
//            //boş görünmesi isağlamak
//            EmptyView()
//        }.fixedSize()
//
//    }
//}
//
////parentView //ebeveyn görünüm
//struct ContentView : View {
//    //@ ile başlayan yapılar property wrapper diye isimlendiriyorlar
//    @State private var darkTheme = DarkTheme()
//
//    var body: some View {
//        VStack {
//            DarkChoiceView(darkTheme: darkTheme)
//
//        }.frame(maxWidth: .infinity,maxHeight: .infinity)
//        //if yapılmış oldu true olduğunda siyah false olduğunda beyaz olucaktır arkaplan rengi
//            .background(darkTheme.isEnable ? .black : .white)
//    }
//}
//#Preview {
//    ContentView()
//}




//---------------3.senaryo----------------
//class DarkTheme : Observable{ // yada
//Observable gözlemlenebilir sınıf
@Observable
class DarkTheme {
    var isEnable : Bool = false
}

//childView
struct DarkChoiceView : View {
    @Bindable var darkTheme : DarkTheme
    
    var body: some View {
        //toggle on olduğunda isEnable true olur diğeri false
        //toggle burda binding yada bindable yada state te olur istediği için verildi
        Toggle(isOn: $darkTheme.isEnable) {
            //boş görünmesi isağlamak
            EmptyView()
        }.fixedSize()
        
        
    }
}

struct DarkChoiceToggleView : View {
    @Environment(DarkTheme.self) private var darkTheme
    var body: some View {
        DarkChoiceView(darkTheme: darkTheme)
    }
}



//genelde böyle viewlere ayrı klasörde yapılır
struct InformationText : View {
    
    @Environment(DarkTheme.self) private var darkTheme
    
    var body: some View {
        Text(darkTheme.isEnable ? "Dark theme Enable" : "Dark Theme Not Enabled")
            .font(.title)
            .foregroundStyle(darkTheme.isEnable ? .white : .black)
    }
}

//parentView //ebeveyn görünüm
struct ContentView : View {
   
    //@Environment(DarkTheme.self)  burda (DarkTheme.self) tipini belirtiyoruz  var word : String gibi
    @Environment(DarkTheme.self) private var darkTheme
    
    var body: some View {
        VStack {
            DarkChoiceToggleView()
            //parametere istemedi
            InformationText()
        }.frame(maxWidth: .infinity,maxHeight: .infinity)
        //if yapılmış oldu true olduğunda siyah false olduğunda beyaz olucaktır arkaplan rengi
            .background(darkTheme.isEnable ? .black : .white)
    }
}

//similasyon uygulamasında çalışan kısım
#Preview {
    //DarkTheme ile tek bir instancesidir 3 ününde
    //bir nevi parametresini böleyle girildi
    ContentView().environment( DarkTheme())
}

//Environment değilde binding yada bindable ile yapılabilirdi ama yeni teknoloji ile ilerlemek istersek böyle

//tabiki darktheme böyle yapılır değil sadece bu bir örnekti bu binding bindable environment ....


