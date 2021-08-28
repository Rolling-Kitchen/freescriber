const findList = document.querySelector('#add-list')
const buttonList = document.querySelector('.button-list')
const allLists = document.querySelectorAll('.list-name')
const listId = document.querySelector('#bookmark_list_id')

allLists.forEach((list) => {
  list.addEventListener('click', (e) => {
    listId.value = e.target.dataset.myId
    buttonList.click()
  })
})
