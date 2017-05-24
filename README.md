# Paint Picker

![Logo](https://raw.githubusercontent.com/brpandey/paint_picker/master/priv/images/paintpicker.png)

### Description
Fun little web app that uses Elm and Phoenix to select paint cans (Phoenix db backend uses Postgres) 
Doesn't write to the DB upon paint can selection, but instead reads from the JSON API 
endpoint together the list of paints (straight http get call -- no channels here)

Sidenote:

Really impressed with Elm and the virtual DOM construction, separation of purity and impurity (handled by Elm runtime).
Happy that the Elm folks got rid of Signals / Mailboxes 

Thanks Bibek

