const { contextBridge, ipcRenderer } = require("electron");

contextBridge.exposeInMainWorld("electronAPI", {
  loadClientData: (fileName) =>
    ipcRenderer.invoke("load-client-data", fileName),
  on: (channel, callback) => {
    ipcRenderer.on(channel, (event, data) => callback(data));
  },
  saveClientData: (fileName, data) =>
    ipcRenderer.invoke("save-client-data", fileName, data),
  send: (channel, data) => {
    ipcRenderer.send(channel, data);
  },
});

contextBridge.exposeInMainWorld("electronEnv", {
  isElectron: true,
});
