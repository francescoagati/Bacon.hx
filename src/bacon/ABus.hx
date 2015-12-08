package bacon;

@:forward abstract ABus<T>(Bus<T>) from Bus<T> to Bus<T> {
  public inline function new(bus:Bus<T>) this = bus;
  @:op(A<<B) public inline function a_plug<T>(stream:ABacon<T>) {
    this.plug(stream);
    return new ABus(this);
  }

  @:op(A<<B) public inline function a_push<T>(obj:T) {
    this.push(obj);
    return new ABus<T>(this);
  }


  @:op(A>>B) public inline function on_value<T>(fn:T->Void) {
    this.onValue(fn);
  }

}
