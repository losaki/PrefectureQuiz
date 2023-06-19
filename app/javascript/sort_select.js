document.addEventListener('DOMContentLoaded', function() {
  const sortSelect = document.querySelector('.sort-select');
  sortSelect.addEventListener('change', function() {
    this.closest('form').submit();
  });
});
