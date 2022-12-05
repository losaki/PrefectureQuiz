import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="photo"
export default class extends Controller {
  /* 静的プロパティを定義 */
  static targets = ["select", "preview", "photo_box", "error"]

  /* 画像ファイルサイズの上限を設定 */
  photoSizeOver(file){
    const fileSize = (file.size)/1000
    if(fileSize > 2000){
      return true
    }else{
      return false
    }
  }

  /* 画像選択時の処理 */
  selectPhoto(){
    this.errorTarget.textContent = ""
    const files = this.selectTargets[0].files
    for(const file of files){
      if(this.photoSizeOver(file)){
        this.errorTarget.textContent = "ファイルサイズの上限(1枚あたり2MB)を超えている画像はアップロードできません。"
      }else{
        this.uploadPhoto(file)
      }
    }
    this.selectTarget.value = ""
  }

  /* 画像アップロード */
  uploadPhoto(file){
    const csrfToken = document.getElementsByName('csrf-token')[0].content
    const formData = new FormData()
    formData.append("photo", file)
    const options = {
      method: 'POST',
      headers: {
        'X-CSRF-Token': csrfToken
      },
      body: formData
    }

    fetch("/quizzes/upload_photo", options) 
      .then(response => response.json())
      .then(data => {
        this.previewPhoto(file, data.id)
      })
      .catch((error) => {
        console.error(error)
      })
  }

  /* 画像プレビュー */
  previewPhoto(file, id){
    const preview = this.previewTarget
    const fileReader = new FileReader()
    const setAttr = (element, obj)=>{
      Object.keys(obj).forEach((key)=>{
        element.setAttribute(key, obj[key])
      })
    }
    fileReader.readAsDataURL(file)
    fileReader.onload = (function () {
      const img = new Image()
      const imgBox = document.createElement("div")
      const imgInnerBox = document.createElement("div")
      const deleteBtn = document.createElement("a")
      const hiddenField = document.createElement("input")
      const imgBoxAttr = {
        "class" : "photo-box inline-flex mx-1 mb-5",
        "data-controller" : "photo",
        "data-photo-target" : "photo_box",
      }
      const imgInnerBoxAttr = {
        "class" : "text-center"
      }
      const deleteBtnAttr = {
        "class" : "link cursor-pointer",
        "data-action" : "click->photo#deletePhoto"
      }
      const hiddenFieldAttr = {
        "name" : "quiz[photo][]",
        "style" : "none",
        "type" : "hidden",
        "value" : id,
      }
      setAttr(imgBox, imgBoxAttr)
      setAttr(imgInnerBox, imgInnerBoxAttr)
      setAttr(deleteBtn, deleteBtnAttr)
      setAttr(hiddenField, hiddenFieldAttr)

      deleteBtn.textContent = "削除"

      imgBox.appendChild(imgInnerBox)
      imgInnerBox.appendChild(img)
      imgInnerBox.appendChild(deleteBtn)
      imgInnerBox.appendChild(hiddenField)
      img.src = this.result
      img.width = 500;

      preview.appendChild(imgBox)
    })
  }

  /* プレビュー画像の削除 */
  deletePhoto(){
    this.photo_boxTarget.remove()
  }
}
