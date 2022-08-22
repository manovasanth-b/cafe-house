function changeh2toInputTag(event){
  var menu_id = event.target.dataset.id
  h2 = document.getElementById(`${menu_id}_h2`)
  menuInput = document.getElementById(`${menu_id}_input`)
  editButton = document.getElementById(`${menu_id}_edit`)
  saveButton = document.getElementById(`${menu_id}_save`)
  cancelButton = document.getElementById(`${menu_id}_cancel`)

  h2.classList.add("hideElement")
  editButton.classList.add("hideElement")

  cancelButton.classList.remove("hideElement")

  menuInput.classList.remove("hideElement")
  saveButton.classList.remove("hideElement")
}

function changeInputToH2Tag(event){
  var menu_id = event.target.dataset.id
  h2 = document.getElementById(`${menu_id}_h2`)
  menuInput = document.getElementById(`${menu_id}_input`)
  editButton = document.getElementById(`${menu_id}_edit`)
  saveButton = document.getElementById(`${menu_id}_save`)
  cancelButton = document.getElementById(`${menu_id}_cancel`)

  h2.classList.remove("hideElement")
  editButton.classList.remove("hideElement")

  cancelButton.classList.add("hideElement")
  menuInput.classList.add("hideElement")
  saveButton.classList.add("hideElement")
}

function onChangeSelectMenuCategoryNameInput(event){
  var value = event.target.value
  menuCategoryNameInputElement = document.querySelector('#new_menu_category_name')
  menuCategoryNameInputLabelElement = document.querySelector('#menu_category_input_label')
  if (value === "Others" && menuCategoryNameInputElement.classList.contains("hideElement")){
    menuCategoryNameInputElement.classList.remove("hideElement")
    menuCategoryNameInputLabelElement.classList.remove("hideElement")
  }else if (!menuCategoryNameInputElement.classList.contains("hideElement")){
    menuCategoryNameInputElement.classList.add("hideElement")
    menuCategoryNameInputLabelElement.classList.add("hideElement")
  }
  };



