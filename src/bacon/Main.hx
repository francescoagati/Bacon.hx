package bacon;

import bacon.EventStream;
import bacon.BaconTools;

class Main {

  public static function main() {
    var bus:bacon.ABus<Int> = new bacon.Bus();

    bus << 2;
    bus >> function(i) trace(i);

  }

}
