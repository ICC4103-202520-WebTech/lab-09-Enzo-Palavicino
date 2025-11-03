# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.bundle.min.js"
pin "trix", to: "https://ga.jspm.io/npm:trix@2.1.4/dist/trix.esm.min.js", preload: true
pin "@rails/actiontext", to: "https://ga.jspm.io/npm:@rails/actiontext@8.0.3/app/assets/javascripts/actiontext.esm.js", preload: true
