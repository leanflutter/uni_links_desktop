import Cocoa
import FlutterMacOS


let kMessagesChannel = "uni_links/messages"
let kEventsChannel = "uni_links/events"

public class UniLinksDesktopPlugin: NSObject, FlutterPlugin, FlutterStreamHandler {
    private static var _instance: UniLinksDesktopPlugin?
    
    private var _eventSink: FlutterEventSink?;
    private var _initialUrl: String?
    
    public static var instance: UniLinksDesktopPlugin {
        get {
            return _instance!
        }
    }
    
    override init(){
        super.init();
        NSAppleEventManager.shared().setEventHandler(self, andSelector: #selector(handleURLEvent(_:with:)), forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = UniLinksDesktopPlugin()
        
        let channel = FlutterMethodChannel(name: kMessagesChannel, binaryMessenger: registrar.messenger)
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        let chargingChannel = FlutterEventChannel(name: kEventsChannel, binaryMessenger: registrar.messenger);
        chargingChannel.setStreamHandler(instance);
        
        _instance = instance
    }
    
    @objc
    public func handleURLEvent(_ event: NSAppleEventDescriptor, with replyEvent: NSAppleEventDescriptor) {
        guard let urlString = event.paramDescriptor(forKeyword: AEKeyword(keyDirectObject))?.stringValue else { return }
        if (_initialUrl == nil) {
            _initialUrl = urlString
        }
        if (_eventSink != nil) {
            _eventSink!(urlString)
        }
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "getInitialLink":
            result(self._initialUrl ?? "");
            break;
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self._eventSink = events;
        return nil;
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self._eventSink = nil;
        return nil;
    }
}
