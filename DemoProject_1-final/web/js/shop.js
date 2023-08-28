var currentCheckbox = null;
var checkboxes = document.getElementsByClassName("brand");
var isChecked = {};

for (var i = 0; i < checkboxes.length; i++) {
  // Khôi phục giá trị lưu trữ cho checkbox khi trang load
  var value = localStorage.getItem(checkboxes[i].value);
  if (value !== null) {
    checkboxes[i].checked = value === "true";
    isChecked[checkboxes[i].value] = checkboxes[i].checked;
    currentCheckbox = checkboxes[i];
  }

  checkboxes[i].onchange = function() {
    // Xóa giá trị lưu trữ cho checkbox đã được bỏ chọn trước đó
    if (!this.checked && isChecked[this.value]) {
      localStorage.removeItem(this.value);
      isChecked[this.value] = false;
      return;
    }

    // Lưu giá trị cho checkbox hiện tại và cập nhật biến currentCheckbox
    localStorage.setItem(this.value, this.checked);
    isChecked[this.value] = true;
    currentCheckbox = this;

    // Bỏ chọn tất cả các checkbox khác
    for (var j = 0; j < checkboxes.length; j++) {
      if (checkboxes[j] !== this) {
        checkboxes[j].checked = false;
        localStorage.removeItem(checkboxes[j].value);
        isChecked[checkboxes[j].value] = false;
      }
    }

    // Submit form
    document.getElementById("myform").submit();
  };
}