# Chromium with NoVNC

## Environment variables:

|       VARIABLE | DESCRIPTION       | DEFAULT VALUE |
|---------------:|:------------------|:-------------:|
|       VNC_PASS | VNC Password      |   CHANGE_IT   |
|      VNC_TITLE | VNC Session Title |   Chromium    |
|     VNC_SHARED | VNC Shared Mode   |     false     |
| VNC_RESOLUTION | VNC Resolution    |   1280x720    |

自编译chromium 做的chrome-novnc, 由于编译的浏览器的平台是amd64 chromium,暂时只支持linux平台. 


## Feature
    用作自编译浏览器在docker容器中的可视化调试.去除了Heroku 的部署配置.