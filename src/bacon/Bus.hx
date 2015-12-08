package bacon;



@:native('Bacon.Bus') extern class Bus<T> extends EventStream<T> {
  public function new():Void;
  public function plug(stream:ABacon<T>):Void;
  public function push(obj:Dynamic):Void;
}
