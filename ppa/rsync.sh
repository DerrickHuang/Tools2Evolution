#!/bin/bash
rsync -av . work.wangyuzhi.brw@bj-a-internal.brainpp.ml:/unsullied/sharefs/wangyuzhi/shared-utils/ppa/
ssh work.wangyuzhi.brw@bj-a-internal.brainpp.ml "find /unsullied/sharefs/wangyuzhi/shared-utils/ppa -type d -exec chmod 755 {} \;"
ssh work.wangyuzhi.brw@bj-a-internal.brainpp.ml "find /unsullied/sharefs/wangyuzhi/shared-utils/ppa -type f -exec chmod 644 {} \;"
