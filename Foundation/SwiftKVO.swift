class ViewController {

    var observation: NSKeyValueObservation?
  
    @IBOutlet weak var scrollView: UIScrollView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        observation = scrollView.observe(\.contentOffset, options: .new) { scrollView, change in
            // do something
        }
    }
}
