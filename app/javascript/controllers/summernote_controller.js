// source https://github.com/luciuschoi/welcome_rails6/tree/features/summernote#5-summernote

import { Controller } from 'stimulus'

import { Octokit } from '@octokit/core'

// summernote용 자바스크립트 (Bootstrap 4 버전용)
require('summernote/dist/summernote-bs4.js');
// summernote용 스타일시트 (Boostrap 4 버전용)
require('summernote/dist/summernote-bs4.css');
// summernote용 한국어 로케일
require('summernote/dist/lang/summernote-ro-RO.min.js');
// codemirror용 자바스크립트
require('codemirror/lib/codemirror.js');
// codemirror용 스타일시트
require('codemirror/lib/codemirror.css');
// codemirror용 language 모드를 xml로 지정
require('codemirror/mode/xml/xml.js');
// codemirror에서 사용하는 테마 스타일시트(monokai)
require('codemirror/theme/monokai.css');
require('codemirror/theme/duotone-light.css');

export default class extends Controller {
  static targets = []

  initialize(){
    // summernote 에디터에서 이모지를 입력할 수 있도록 한번만 ajax 호출
    const octokit = new Octokit({ auth: '1f1acc64618f2fc41' + 'ace6284745d23e69e80b5ed' })

    window.response = octokit.request('GET /emojis')
    response.then((fulfilled) => { 
        window.emojis = Object.keys(fulfilled.data)
        window.emojiUrls = fulfilled.data
    })
  }

  connect(){
    console.log("Connection established to Summernote.")
    $('[data-editor="summernote"]').summernote({
      height: 300,
      focus: true,
      lang: 'ro-RO',
      prettifyHtml: true,
      placeholder: 'type starting with : and any alphabet',
      hint: {
        match: /:([\-+\w]+)$/,
        search: function (keyword, callback) {
          callback($.grep(emojis, function (item) {
            return item.indexOf(keyword)  === 0;
          }));
        },
        template: function (item) {
          var content = emojiUrls[item];
          return '<img src="' + content + '" width="20" /> :' + item + ':';
        },
        content: function (item) {
          var url = emojiUrls[item];
          if (url) {
            return $('<img />').attr('src', url).css('width', 20)[0];
          }
          return '';
        }
      },
      codemirror: { 
        theme: 'duotone-light',
        mode: "xml",
        lineNumbers: true,
        lineWrapping: true,
        tabSize: 2,
        tabMode: 'indent'
      },
      callbacks: {
        // Store the images in the database, not separately

        /* onImageUpload: function(files){
          console.log('called onImageUpload.')
          // multiple files uploading...
          for(let i = 0; i < files.length; i++){
            console.log(files[i])
            sendFile(files[i], $(this))
          }
        },
        onMediaDelete: function(target, editor, editiable){
          console.log("called onMediaDelete.")
          let upload_id = target[0].id
          if(!!upload_id){
            deleteFile(upload_id)
          }
          target.remove()
        } */
      },
      toolbar: [
        ['styletype', ['style']],
        //['font', ['fontname', 'fontsize']],
        ['style', ['bold', 'italic', 'underline', 'clear']],
        ['fontstyle', ['strikethrough', 'superscript', 'subscript']],
        ['para', ['ul', 'ol', 'paragraph']],
        ['misc', ['fullscreen', 'codeview', 'help']],
      ],
      icons: {
        'align': 'far fa-align',
        'alignCenter': 'far fa-align-center',
        'alignJustify': 'far fa-align-justify',
        'alignLeft': 'far fa-align-left',
        'alignRight': 'far fa-align-right',
        'indent': 'far fa-indent',
        'outdent': 'far fa-outdent',
        'arrowsAlt': 'far fa-expand-arrows',
        'bold': 'far fa-bold',
        'caret': 'far fa-caret-down',
        'circle': 'far fa-circle',
        'close': 'far far fa-close',
        'code': 'far fa-code',
        'eraser': 'far fa-remove-format',
        'font': 'far fa-font',
        'italic': 'far fa-italic',
        'link': 'far fa-link',
        'unlink': 'far fa-chain-broken',
        'magic': 'far fa-paragraph',
        'menuCheck': 'far fa-check',
        'minus': 'far fa-minus',
        'orderedlist': 'far fa-list-ol',
        'pencil': 'far fa-pencil',
        'picture': 'far fa-picture-o',
        'question': 'far fa-question',
        'redo': 'far fa-repeat',
        'square': 'far fa-square',
        'strikethrough': 'far fa-strikethrough',
        'subscript': 'far fa-subscript',
        'superscript': 'far fa-superscript',
        'table': 'far fa-table',
        'textHeight': 'far fa-text-height',
        'trash': 'far fa-trash',
        'underline': 'far fa-underline',
        'undo': 'far fa-undo',
        'unorderedlist': 'far fa-list-ul',
        'video': 'far fa-video-camera'
      },
      styleTags: [
        'p', 'pre', 'h1', 'h2', 'h3', 'h4'
      ],
    })

    function sendFile(file, toSummernote){
      console.log('called sendFile().')
      let data = new FormData()
      data.append('upload[image]', file)
      $.ajax({
        data: data,
        type: 'POST',
        url: '/uploads.json',
        cache: false,
        contentType: false,
        processData: false,
        success: function(data){
          console.log("image url: ", data.url)
          console.log('successfully created.')
          let img = document.createElement("IMG")
          img.src = data.url
          img.setAttribute('id', data.upload_id)
          toSummernote.summernote("insertNode", img)
        }
      })
    }

    function deleteFile(file_id){
      $.ajax({
        type: 'DELETE',
        url: `/uploads/${file_id}`,
        cache: false,
        contentType: false,
        processData: false
      })
    }
  }
}