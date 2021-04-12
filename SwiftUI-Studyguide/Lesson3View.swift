import SwiftUI

struct Lesson3View: View {
   @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
   
   @State private var firstName: String = ""
   @State private var lastName: String = ""
   @State private var emailAddress: String = ""
   @State private var mobileNumber: String = ""
   @State private var gender: String = ""
   @State private var password: String = ""
   @State private var message: String = ""
   
   @State private var isDisable: Bool = false
   @State private var showToast: Bool = false
   
    var body: some View {
      NavigationView {
         ZStack{
            VStack (alignment: .leading) {
               appBar(presentationMode: self.presentationMode)
               
               Text("Form Sample")
                  .font(.title)
                  .padding()
               
               formView(firstName: $firstName,
                        lastName: $lastName,
                        emailAddress: $emailAddress,
                        mobileNumber: $mobileNumber,
                        password: $password,
                        message: $message,
                        buttonToggle: $showToast)
                  .keyboardManagement()
               
            }
            
            if showToast {
               toastView(isShown: $showToast)
                  .transition(.asymmetric(insertion: .offset(x: 0, y: -80), removal: .offset(x: 0, y: 60)))
                  .animation(.easeInOut)
            }
            
         }
      }
      .navigationBarTitle("")
      .navigationBarBackButtonHidden(true)
      .navigationBarHidden(true)
    }
}

private struct appBar: View {
   @Binding var presentationMode: PresentationMode
   var body: some View {
      VStack {
         HStack {
            Button(action: {
               self.$presentationMode.wrappedValue.dismiss()
            }){
               Image(systemName: "chevron.left")
                  .foregroundColor(Color.white)
               
               Text("Lesson 3")
                  .navigationBarTitle("")
                  .navigationBarBackButtonHidden(true)
                  .navigationBarHidden(true)
                  .foregroundColor(Color.white)
            }
            
            Spacer()
         }
      }
      .padding()
      .background(Color.blue.edgesIgnoringSafeArea(.top).shadow(color: .black, radius: 3))
   }
}

private struct formView: View {
   @Binding var firstName: String
   @Binding var lastName: String
   @Binding var emailAddress: String
   @Binding var mobileNumber: String
   @Binding var password: String
   @Binding var message: String
   @Binding var buttonToggle: Bool
   
   var body: some View {
      GeometryReader{ geo in
         VStack {
            
            ScrollView {
               VStack {
                  InputView(placeholder: "First Name", text: self.$firstName)
                  
                  InputView(placeholder: "Last Name", text: self.$lastName)
                  
                  InputView(placeholder: "Email Address", text: self.$emailAddress)
                  
                  InputView(placeholder: "Mobile Number", text: self.$mobileNumber)
                  
                  SecureField("Password", text: self.$password)
                  .keyboardType(.alphabet)
                  .padding(10)
                  .overlay(Divider(), alignment: .bottom)
                  
                  CustomTextEditor(placeholder:"Message",
                                message: self.$message)
                  .frame(height: 120)
                  .overlay(Divider(), alignment: .bottom)
                  
                  HStack(alignment: .center) {
                     Spacer()
                     Button(action: {
                        self.buttonToggle.toggle()
                     }){
                        Text("Send")
                           .frame(width: 200, height: 50)
                           .background(Color.blue)
                           .foregroundColor(Color.white)
                           .cornerRadius(8)
                     }.padding()
                     Spacer()
                  }
               }
            }
            
         }
         .padding(.horizontal)
      }
   }
}

private struct InputView: View {
   var placeholder: String
   @Binding var text: String
   
   var body: some View {
      VStack {
         TextField(self.placeholder, text: self.$text)
         .keyboardType(.alphabet)
      }
      .padding(10)
      .overlay(Divider(), alignment: .bottom)
   }
}

private struct CustomTextEditor: UIViewRepresentable {
   var placeholder: String
   @Binding var message: String
   
   func makeUIView(context: Context) -> UITextView {
      let textView = UITextView()
      
      textView.font = UIFont.systemFont(ofSize: 15)
      textView.textColor = .gray
      textView.isEditable = true
      textView.isSelectable = true
      textView.isUserInteractionEnabled = true
      textView.delegate = context.coordinator
      
      return textView
   }
   
   func updateUIView(_ uiView: UITextView, context: Context){
      uiView.text = self.placeholder
   }
   
   func makeCoordinator() -> Coordinator {
      Coordinator(self)
   }
   
   class Coordinator: NSObject, UITextViewDelegate{
      var parent: CustomTextEditor
      
      init(_ parent: CustomTextEditor){
         self.parent = parent
      }
      
      func textViewDidBeginEditing(_ textView: UITextView) {
         if textView.text == parent.placeholder {
            textView.text = ""
            textView.textColor = .black
         }
      }
      
      func textViewDidEndEditing(_ textView: UITextView) {
         if textView.text == "" {
            textView.text = parent.placeholder
            textView.textColor = .gray
         }
      }

   }
}

private struct toastView: View {
   @Binding var isShown: Bool
   
   var body: some View {
      VStack{
         Button(action: {
            self.dismiss()
         }){
            HStack{
               Text("Sample Toast button")
               Spacer()
            }
         }
         .frame(width: 350, height: 50)
         .padding(.horizontal)
         .foregroundColor(Color.white)
         .background(Color.green)
         .cornerRadius(8)
         .offset(x: 0, y: isShown ? 60 : -80)
         
         Spacer()
      }
      .onAppear(){
         self.dismiss()
      }
   }
   
   func dismiss(){
      DispatchQueue.main.asyncAfter(deadline: .now() + 5){
         self.isShown = false
      }
   }
}

private struct KeyboardManagement: ViewModifier {
    @State private var offset: CGFloat = 0
    func body(content: Content) -> some View {
        GeometryReader { geo in
            content
                .onAppear {
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (notification) in
                        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
                        withAnimation(Animation.easeOut(duration: 0.5)) {
                           self.offset = keyboardFrame.height - geo.safeAreaInsets.bottom
                        }
                    }
                    NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (notification) in
                        withAnimation(Animation.easeOut(duration: 0.1)) {
                           self.offset = 0
                        }
                    }
                }
            .padding(.bottom, self.offset)
        }
    }
}


extension View {
    func keyboardManagement() -> some View {
        self.modifier(KeyboardManagement())
    }
}

struct Lesson3View_Previews: PreviewProvider {
    static var previews: some View {
        Lesson3View()
    }
}
