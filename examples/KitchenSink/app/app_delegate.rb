class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @form = Formotion::Form.new({
      title: "Kitchen Sink",
      sections: [{
        title: "Section Title",
        footer: "This is the footer for the section. It's good for displaying detailed data about the section.",
        rows: [{
          title: "Static",
          type: :static,
        }, {
          title: "Email",
          key: :email,
          placeholder: "me@mail.com",
          image: "email",
          type: :email,
          auto_correction: :no,
          auto_capitalization: :none,
          input_accessory: :done
        }, {
          title: "Image Accessory",
          subtitle: "You can add an image to any row type",
          image: "arrow-up",
          type: :static
        }, {
          title: "Image from URL",
          subtitle: "Or from a URL!",
          image: "http://placekitten.com/80/80?t=#{Time.now.to_i}",
          type: :static
        }, {
          title: "Gender",
          key: :gender,
          type: :picker,
          items: [['Female', 'f'],['fds', 'df'],['fddfsfds', 'f3'],['fdfafds', 'f33'], ['Male', 'm']],
          value: 'm',
          input_accessory: :done
        }, {
          title: "Password",
          key: :password,
          placeholder: "required",
          type: :string,
          secure: true
        }, {
          title: "Phone",
          key: :phone,
          placeholder: "555-555-5555",
          type: :phone,
          auto_correction: :no,
          auto_capitalization: :none,
          input_accessory: :done
        }, {
          title: "Number",
          key: :number,
          placeholder: "12345",
          type: :number,
          auto_correction: :no,
          auto_capitalization: :none,
          input_accessory: :done
        }, {
          title: "Subtitle",
          subtitle: "Confirmation",
          key: :confirm,
          placeholder: "required",
          type: :string,
          secure: true
        }, {
          title: "Row Height",
          key: :row_height,
          placeholder: "60px",
          type: :string,
          row_height: 60
        }, {
            title: "Text",
            key: :text,
            type: :text,
            placeholder: "Enter your text here",
            row_height: 100
        }, {
          title: "Big Text",
          key: :text,
          type: :text,
          font: {name: 'Helvetica', size: 24},
          placeholder: "Enter your big text here",
          row_height: 100
        }, {
          title: "Small Text",
          key: :text,
          type: :text,
          font: {name: 'Chalkduster', size: 8},
          placeholder: "Enter your small text here",
          row_height: 100
        }, {
          title: "Check",
          key: :check,
          type: :check,
          value: true
        }, {
          title: "Remember?",
          key: :remember,
          type: :switch,
        }, {
          title: "Date Full",
          subtitle: "w/ :value",
          value: 326937600,
          key: :date_long,
          type: :date,
          format: :full
        }, {
          title: "Date Medium",
          subtitle: "w/ :value",
          value: 1341273600,
          key: :date_medium,
          type: :date,
          format: :medium
        }, {
          title: "Date Short",
          subtitle: "w/ :placeholder",
          placeholder: "DOB",
          key: :date_short,
          type: :date,
          format: :short
        }, {
          title: "Date (Time)",
          subtitle: "w/picker_mode => :time",
          key: :date_time_short,
          type: :date,
          picker_mode: :time,
          format: :short
        }, {
          title: "Slider",
          key: :slider,
          type: :slider,
          range: (1..100),
          value: 25
        }]
      }, {
        title: "Select One",
        key: :account_type,
        select_one: true,
        rows: [{
          title: "A",
          key: :a,
          type: :check,
        }, {
          title: "B (value: true)",
          value: true,
          key: :b,
          type: :check,
        }, {
          title: "C",
          key: :c,
          type: :check,
        }]
      }, {
        title: "Subforms",
        rows: [{
          title: "Subform",
          subtitle: "With display_key",
          type: :subform,
          key: :subform,
          display_key: :type,
          subform: {
            title: "Account Type",
            sections: [{
              key: :type,
              select_one: true,
              rows: [{
                title: "Free",
                key: :Free,
                type: :check,
              }, {
                title: "Basic",
                value: true,
                key: :Basic,
                type: :check,
              }, {
                title: "Pro",
                key: :Pro,
                type: :check,
              }]
            }, {
              rows: [{
                title: "Advanced",
                type: :subform,
                key: :advanced,
                subform: {
                  title: "Advanced",
                  sections: [{
                    key: :currency,
                    select_one: true,
                    rows: [{
                      title: "USD",
                      value: true,
                      key: :usd,
                      type: :check,
                    }, {
                      title: "EUR",
                      key: :eur,
                      type: :check,
                    }, {
                      title: "CHF",
                      key: :chf,
                      type: :check,
                    }]
                  }, {
                    rows: [{
                      title: 'Back',
                      type: :back
                    }]
                  }]
                }
              }]
            }, {
              rows: [{
                title: 'Back',
                type: :back
              }]
            }]
          }
        }]
      }, {
        rows: [{
          title: "Submit",
          type: :submit,
        }]
      }]
    })

    @view_controller = Formotion::FormController.alloc.initWithForm(@form)
    @view_controller.form.on_submit do |form|
      form.active_row && form.active_row.text_field.resignFirstResponder
      alert = UIAlertView.alloc.init
      alert.title = "@form.render"
      alert.message = @form.render.to_s
      alert.addButtonWithTitle("OK")
      alert.show
    end

    @view_controller.navigationItem.rightBarButtonItem = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemSave, target:self, action:'submit')

    @navigation_controller = UINavigationController.alloc.initWithRootViewController(@view_controller)

    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible

    true
  end

  def submit
    @form.submit
  end
end
