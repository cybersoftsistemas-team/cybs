window.DataStorage = {
  load: function (sender, fileName) {
    const value = localStorage.getItem(fileName) || "";
    ajaxRequest(sender, "LoadClientData", [
      "file=" + fileName,
      "value=" + value,
    ]);
  },
  save: function (fileName, data) {
    try {
      localStorage.setItem(fileName, data);
    } catch (err) {
      console.error("Error saving data:", err.message);
    }
  },
}
