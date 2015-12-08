package bacon;

@:forward abstract ABacon<T>(EventStream<T>) from EventStream<T> to EventStream<T> {
  public inline function new(stream:EventStream<T>) this = stream;

  @:op(A+B) public inline function a_merge(stream:Dynamic) {
    return new ABacon(untyped this.merge(stream));
  }
}
