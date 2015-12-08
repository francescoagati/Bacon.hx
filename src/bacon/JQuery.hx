package bacon;



#if (macro || neko)
  import haxe.macro.Expr;
  typedef ExpES<T> = ExprOf<EventStream<T>>;
#end



typedef ES<T> = EventStream<T>;



class JQuery {

  #if (!macro)

  inline public static function do_null<T>(stream:ES<T>) stream.onValue(function(value) {});

  inline public static function frp_event_stream<T>(root:js.JQuery,event:String):ES<T>
    return untyped root.asEventStream(event);

  inline public static function frp_live_stream<T>(root:js.JQuery,event:String,selector:String):ES<T>
    return untyped root.asEventStream(event,selector);
  #end


}
