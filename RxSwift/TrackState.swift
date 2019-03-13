import RxSwift

public typealias State = PublishRelay<UIState>

public enum UIState {
    case idle
    case loading(String?)
    case success(String?)
    case failure(String?)
    case completed
    
    public var isSuccess: Bool {
        switch self {
        case .success:
            return true
        default:
            return false
        }
    }
    
    public var isFailure: Bool {
        switch self {
        case .failure:
            return true
        default:
            return false
        }
    }
}

public enum Loading {
    case none
    case start(String?)
}

struct UIStateToken<E>: Disposable {
    
    private let _source: Observable<E>
    
    init(source: Observable<E>) {
        _source = source
    }
    
    func asObservable() -> Observable<E> {
        return _source
    }
    
    public func dispose() {}
}

public extension ObservableConvertibleType {
    
    /// Toast
    ///
    /// - Parameters:
    ///   - state: UIState publish relay
    ///   - loading: loadng 选项
    ///   - success: 成功提示信息
    ///   - failure: 失败提示信息
    /// - Returns: 绑定的序列
    func trackState(
        _ state: State,
        loading: Loading = .start(nil),
        success: String? = nil,
        failure: @escaping (Error) -> String? = { _ in nil }
        )
        -> Observable<E>
    {
        return Observable.using({ () -> UIStateToken<E> in
            switch loading {
            case .none:
                break
            case .start(let text):
                state.accept(.loading(text))
            }
            
            return UIStateToken(source: self.asObservable())
        }, observableFactory: {
            return $0.asObservable().do(onNext: { _ in
                state.accept(.success(success))
            }, onError: {
                state.accept(.failure(failure($0)))
            }, onCompleted: {
                state.accept(.completed)
            })
        })
    }
}
