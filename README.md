# PPP-static
Prices-Point-Positioning static method and .sp3 file interpolator 

![satelite ground track](https://www.gim-international.com/cache/b/c/0/2/0/bc0205434d2016efc4246efaacdcd68bd562024d.png)

Precise point positioning (PPP) stands out as an optimal approach for providing standalone static and kinematic
geodetic point positioning solutions using all the available GNSS constellations. Combining precise satellite
orbits and clocks with un-differenced, dual-frequency, pseudo-range and carrier-phase observables, PPP is able to
provide position solutions at centimeter-level precision. PPP offers an attractive alternative to Differential 
Global Navigation Satellite System (DGNSS), with the advantage that it does not require simultaneous observations 
from multiple stations, i.e., it only needs a single geodetic receiver. In practice, PPP makes use of a network of
reference stations in order to compute precise estimates of GNSS satellites orbits and clock errors. Nevertheless,
it requires fewer reference stations globally distributed as compared with classic differential approaches
(e.g. Real Time Kinematics, RTK), and one set of precise orbit and clock data (computed by a processing center) 
is valid for all users everywhere. Furthermore, as the precise orbits and clocks are calculated from a global network 
of reference stations, the same set of satellites is simultaneously observed by multiple stations, which enables PPP
to provide position solutions rather robust to individual reference station failures.
