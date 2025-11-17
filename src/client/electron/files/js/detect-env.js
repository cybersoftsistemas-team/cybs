window.AppEnv = {
  isElectron: function () {
    return window.electronEnv && window.electronEnv.isElectron === true;
  },
  safeSendToElectron: function (channel, data) {
    if (window.AppEnv.isElectron()) {
      window.electronAPI.send(channel, data);
    }
  },
};
