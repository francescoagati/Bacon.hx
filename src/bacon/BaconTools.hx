package bacon;


#if (macro || neko)
  import haxe.macro.Expr;


typedef ExpES<T> = ExprOf<EventStream<T>>;

#end



typedef ES<T> = EventStream<T>;



class BaconTools {

  public static macro function bindExpr<T>(stream:ExpES<T>,expr:haxe.macro.Expr):ExpES<T> {
    return macro $stream.onValue(function(_) {
      $expr = _;
    });
  }

  public static macro function bindFunc<T>(stream:ExpES<T>,expr:haxe.macro.Expr):ExpES<T> {
    return macro $stream.onValue(function(_) {
      $expr(_);
    });
  }

  public static macro function map_cons<T>(stream:ExpES<T>,expr:haxe.macro.Expr):ExpES<T> {
    return macro $stream.map(function(el) {
      return $expr;
    });
  }

  public static macro function filter_expr<T>(stream:ExpES<T>,expr:haxe.macro.Expr):ExpES<T> {
    return macro $stream.filter(thx.Functions.fn($expr));
  }


  public static macro function filterExpr<T>(stream:ExpES<T>,expr:haxe.macro.Expr):ExpES<T> {
    return macro $stream.filter(thx.Functions.fn($expr));
  }



  public static macro function map_expr<T>(stream:ExpES<T>,expr:haxe.macro.Expr):ExpES<T> {
    return macro $stream.map(thx.Functions.fn($expr));
  }


  public static macro function mapExpr<T>(stream:ExpES<T>,expr:haxe.macro.Expr):ExpES<T> {
    return macro $stream.map(thx.Functions.fn($expr));
  }


  public static macro function actionExpr<T>(stream:ExpES<T>,expr:haxe.macro.Expr):ExpES<T> {
    return macro $stream.doAction(thx.Functions.fn($expr));
  }

  #if (!macro)

  inline public static function do_null<T>(stream:ES<T>) stream.onValue(function(value) {});

  #end
}
