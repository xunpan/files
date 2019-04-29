#!/bin/bash

set -x

# testing purpose only to make sure this script is executed
echo "hello" > /tmp/hook.test.log


cat <<EOF >~/1.sh
#!/bin/bash
echo "secret<$$>: hello" >> /tmp/generated1.hook.test.log
EOF

bash -x ~/1.sh

cat <<EOF >~/2.sh
#!/bin/bash
echo "secret<$$>: hi" >> /tmp/generated2.hook.test.log
EOF

chmod a+x ~/2.sh


sleep 300


