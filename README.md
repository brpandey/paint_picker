# Paint Picker

![Logo](https://raw.githubusercontent.com/brpandey/paint_picker/master/priv/images/paintpicker.png)

### Description
Fun little web app that uses Elm and Phoenix to select paint cans (using Postgres) 
Simply reads from the JSON API endpoint and returns the clickable list of paints 
(straight http get call -- no channels here)

Sidenote:

Really impressed with Elm and the virtual DOM construction, separation of purity and impurity 
(handled by Elm runtime).
Happy that the Elm folks replaced things like Signals, Mailboxes for Cmd, Sub


### Snippets

Here's some Phoenix code snippets (router and controller)

```elixir

  # Other scopes may use custom stacks.
  scope "/api", PaintPicker do
    pipe_through :api

    resources "/paints", PaintController, except: [:new, :edit]
  end

```


```elixir

  def index(conn, _params) do
    paints = Repo.all(Paint)
    render(conn, "index.json", paints: paints)
  end

```


Here's the JSON fetch code

```haskell

        getPaints : Cmd Msg
        getPaints =
            -- Wraps the Http request in a Command Msg
            -- Cmd will be performed by Elm runtime (will go back to update eventually)
            -- Note unlike Elixir, Elm pipes into the last-rightmost arg == partial functions
            -- The Msg will be a list of already validated Paint records
            (Decode.at [ "data" ] (Decode.list paintDecoder))
                    |> Http.get paintsApiUrl
                    |> Http.send NewPaints

```

Thanks Bibek

