package bacon;


@:native('Bacon')
extern class Bacon {
  public static function combineTemplate<T>(template:Dynamic):EventStream<T>;
  public static function fromCallback<T>(fn:Dynamic->Void):EventStream<T>;
}


extern class EventStream<T> {
  public function new():Void;
  public function onValue<T>(fn:Dynamic->Void):EventStream<T>;
  public function doAction<T>(fn:Dynamic->Void):EventStream<T>;
  public function flatMap<T1>(fn:Dynamic->Dynamic):EventStream<T>;
  public function map<T>(fn:Dynamic->Dynamic):EventStream<T>;
  public function filter<T>(fn:T->Bool):EventStream<T>;
  public function log<T>(?msg:String):EventStream<T>;
  public function toProperty<T>(obj:Dynamic):EventStream<T>;
  public function merge<T>(stream:EventStream<T>):EventStream<T>;
  public function skipDuplicates<T>():EventStream<T>;
  public function debounce<T>(n:Int):EventStream<T>;
  public function debounceImmediate<T>(n:Int):EventStream<T>;
  public function bufferingThrottle<T>(n:Int):EventStream<T>;
  public function throttle<T>(n:Int):EventStream<T>;
  public function delay<T>(n:Int):EventStream<T>;
  public function take<T>(n:Int):EventStream<T>;
}


  






/*

typedef Event<T> = {
	function value():T;
	function hasValue():Bool;
	function isNext():Bool;
	function isInitial():Bool;
	function isError():Bool;
	function isEnd():Bool;
};
typedef Error<T> = {
	>Event<T>,
};
typedef End<T> = {
	>Event<T>,
};
typedef Initial<T> = {
	>Event<T>,
};
typedef Next<T> = {
	>Event<T>,
};
typedef Observable<T> = {
	function onValue(fn:T -> Void):Void;
	function onError(fn:Dynamic -> Void):Void;
	function onEnd(fn:Void -> Void):haxe.Constraints.Function;
	function map<U>(fn:T -> U):EventStream<U>;
	function mapError(fn:Dynamic -> Dynamic):EventStream<T>;
	function errors():EventStream<Dynamic>;
	function skipErrors():EventStream<T>;
	@:overload(function(value:T):EventStream<T> { })
	function mapEnd(f:Void -> T):EventStream<T>;
	@:overload(function(boolean:Dynamic):EventStream<T> { })
	@:overload(function(propertyExtractor:String):EventStream<T> { })
	@:overload(function(property:Property<Bool>):EventStream<T> { })
	function filter(f:T -> Bool):EventStream<T>;
	@:overload(function(property:Property<Bool>):EventStream<T> { })
	function takeWhile(f:T -> Bool):EventStream<T>;
	function take(n:Float):EventStream<T>;
	function takeUntil(stream:EventStream<Dynamic>):EventStream<T>;
	function skip(n:Float):EventStream<T>;
	function delay(delay:Float):EventStream<T>;
	function throttle(delay:Float):EventStream<T>;
	function debounce(delay:Float):EventStream<T>;
	function debounceImmediate(delay:Float):EventStream<T>;
	@:overload(function(propertyExtractor:String):EventStream<T> { })
	function doAction(f:T -> Void):EventStream<T>;
	function not():EventStream<Bool>;
	function flatMap<U>(f:T -> Observable<U>):EventStream<U>;
	function flatMapLatest<U>(f:T -> Observable<U>):EventStream<U>;
	function flatMapFirst<U>(f:T -> Observable<U>):EventStream<U>;
	function scan<U>(seed:U, f:U -> T -> U):EventStream<U>;
	function fold<U>(seed:U, f:U -> T -> U):Property<U>;
	function reduce<U>(seed:U, f:U -> T -> U):Property<U>;
	function diff<U>(start:T, f:T -> T -> U):Property<U>;
	function zip<U, V>(other:EventStream<U>, f:T -> U -> V):EventStream<V>;
	function slidingWindow(max:Float, ?min:Float):Property<Array<T>>;
	function log():Observable<T>;
	function combine<U, V>(other:Observable<U>, f:T -> U -> V):Property<V>;
	function withStateMachine<U, V>(initState:U, f:U -> Event<T> -> StateValue<U, V>):EventStream<V>;
	function decode(mapping:Dynamic):Property<Dynamic>;
	function awaiting<U>(other:Observable<U>):Property<Bool>;
	function endOnError(?f:T -> Bool):Observable<T>;
	function withHandler(f:Event<T> -> Dynamic):Observable<T>;
	function name(name:String):Observable<T>;
	function withDescription(args:haxe.extern.Rest<Dynamic>):Observable<T>;
};
typedef StateValue<State, Type> = {
	var _0 : State;
	var _1 : Array<Event<Type>>;
};
typedef Property<T> = {
	>Observable<T>,
	function toEventStream():EventStream<T>;
	function subscribe(f:Event<T> -> Dynamic):Void -> Void;
	function onValue(f:T -> Dynamic):Void -> Void;
	function onValues(f:haxe.extern.Rest<Dynamic> -> Dynamic):Void -> Void;
	function assign(obj:Dynamic, method:String, params:haxe.extern.Rest<Dynamic>):Void;
	function sample(interval:Float):EventStream<T>;
	@:overload(function(property:Property<Dynamic>):Property<T> { })
	@:overload(function<U, V>(obs:Observable<U>, f:T -> U -> V):EventStream<V> { })
	function sampledBy(stream:EventStream<Dynamic>):EventStream<T>;
	function skipDuplicates(?isEqual:T -> T -> Bool):Property<T>;
	function changes():EventStream<T>;
	function and(other:Property<T>):Property<T>;
	function or(other:Property<T>):Property<T>;
	function startWith(value:T):Property<T>;
};
typedef EventStream<T> = {
	>Observable<T>,
	@:overload(function<U>(property:Property<U>):EventStream<U> { })
	function map<U>(fn:T -> U):EventStream<U>;
	function subscribe(f:Event<T> -> Dynamic):Void -> Void;
	function onValue(f:T -> Dynamic):Void -> Void;
	function onValues(f:haxe.extern.Rest<Dynamic> -> Dynamic):Void -> Void;
	function skipDuplicates(?isEqual:T -> T -> Bool):EventStream<T>;
	function concat(other:EventStream<T>):EventStream<T>;
	function merge(other:EventStream<T>):EventStream<T>;
	function startWith(value:T):EventStream<T>;
	@:overload(function(property:Property<Bool>):EventStream<T> { })
	function skipWhile(f:T -> Bool):EventStream<T>;
	function skipUntil(stream:EventStream<Dynamic>):EventStream<T>;
	@:overload(function(f:haxe.Constraints.Function -> Void):EventStream<Array<T>> { })
	function bufferWithTime(delay:Float):EventStream<Array<T>>;
	function bufferWithCount(count:Float):EventStream<Array<T>>;
	function bufferWithTimeOrCount(delay:Float, count:Float):EventStream<Array<T>>;
	function toProperty(?initialValue:T):Property<T>;
};
typedef Bus<T> = {
	>EventStream<T>,
	function push(value:T):Void;
	function end():Void;
	function error(e:Error<T>):Void;
	function plug(stream:EventStream<T>):Void;
};
extern class BaconTopLevel {
	static var require : String -> Dynamic;
}




 */
