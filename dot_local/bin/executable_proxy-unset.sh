#!/bin/bash -xe
rm /tmp/.proxy-unset.sh||true
sed    "s/-A/-D/g"  ~/.local/bin/proxy-set.sh > /tmp/.proxy-unset.sh
sed -i "s/-N/-X/g"  /tmp/.proxy-unset.sh
sed -i "s/-xe/-x/g" /tmp/.proxy-unset.sh
sed -i '2{H;d}; ${p;x;s/^\n//}' /tmp/.proxy-unset.sh
sed -i "s/start/stop/g"     /tmp/.proxy-unset.sh
chmod +x /tmp/.proxy-unset.sh
sudo /tmp/.proxy-unset.sh
