defmodule Skrap.Factory.HostContent do
  alias Faker.{Date, Internet, Person, Superhero, UUID}

  def manga_host(resource, opts \\ [])

  def manga_host(:manga, opts) do
    author = Keyword.get_lazy(opts, :author, &Person.name/0)
    cover_url = Keyword.get_lazy(opts, :cover_url, &Internet.image_url/0)
    illustrator = Keyword.get_lazy(opts, :illustrator, &Person.name/0)
    name = Keyword.get_lazy(opts, :name, &Superhero.name/0)

    content = [
      {"section", [],
       [
         {"div", [{"class", "w-container"}],
          [
            {"div", [{"class", "box-content box-perfil"}],
             [
               {"div", [{"class", "w-row"}],
                [
                  {"div", [{"class", "w-col w-col-3"}],
                   [
                     {"div", [{"class", "widget"}],
                      [
                        {"picture", [],
                         [
                           {"img",
                            [
                              {"class", "image-3"},
                              {"src", cover_url},
                              {"alt", name}
                            ], []}
                         ]}
                      ]}
                   ]},
                  {"div", [{"class", "w-col w-col-7"}],
                   [
                     {"article", [{"class", "article"}],
                      [
                        {"h1", [{"class", "title"}], [name]},
                        {"div", [{"class", "text"}],
                         [
                           {"div", [{"class", "box-content alert alert-left w-row"}],
                            [
                              {"div", [{"class", "w-col w-col-6"}],
                               [
                                 {"ul", [{"class", "w-list-unstyled"}],
                                  [
                                    {"li", [],
                                     [{"div", [], [{"strong", [], ["Tipo: "]}, "Mangá"]}]},
                                    {"li", [],
                                     [{"div", [], [{"strong", [], ["Status: "]}, "Ativo"]}]},
                                    {"li", [],
                                     [{"div", [], [{"strong", [], ["Autor: "]}, author]}]},
                                    {"li", [],
                                     [{"div", [], [{"strong", [], ["Arte: "]}, illustrator]}]}
                                  ]}
                               ]}
                            ]}
                         ]}
                      ]}
                   ]}
                ]}
             ]}
          ]}
       ]}
    ]

    %{
      data: %{
        author: author,
        cover_url: cover_url,
        illustrator: illustrator,
        name: name
      },
      content: content
    }
  end

  def manga_host(:chapter, opts) do
    random_date_fn = fn -> 1000 |> :rand.uniform() |> Date.backward() end
    name_prefix = "Capítulo "

    added_at = Keyword.get_lazy(opts, :added_at, random_date_fn)
    id = Keyword.get_lazy(opts, :id, &UUID.v4/0)
    name = Keyword.get(opts, :name, name_prefix <> id)
    uri = Keyword.get_lazy(opts, :uri, &Internet.url/0)

    formatted_added_at = Calendar.strftime(added_at, "%b %0d, %Y")

    content = [
      {"div", [{"id", "pop-#{id}"}, {"class", "cap"}],
       [
         {"div", [{"class", "card pop"}],
          [
            {"div", [{"class", "pop-title"}],
             [name_prefix, {"span", [{"class", "btn-caps"}], [id]}]},
            {"div", [{"class", "pop-content"}],
             [
               {"small", [{"class", "clearfix"}],
                [
                  "Traduzido por ",
                  {"strong", [], [Person.name()]},
                  {"br", [], []},
                  "\nAdicionado em #{formatted_added_at}"
                ]},
               {"div", [{"class", "tags"}],
                [
                  {"a",
                   [
                     {"href", uri},
                     {"title", "Ler Online - #{name} []"},
                     {"class", "btn-green w-button pull-left"}
                   ], [{"i", [{"class", "icon-file"}], []}, " Ler Online"]}
                ]}
             ]}
          ]},
         {"a",
          [
            {"class", "btn-caps w-button"},
            {"rel", "popover"},
            {"href", "javascript:void(0)"},
            {"data-pop", "#pop-#{id}"},
            {"id", id},
            {"title", name}
          ], [id]}
       ]}
    ]

    %{
      content: content,
      data: %{
        added_at: added_at,
        id: id,
        name: name,
        uri: uri
      }
    }
  end

  def manga_host(:summary, opts) do
    random_length_fn = fn -> :rand.uniform(10) end

    random_chapters_length = Keyword.get_lazy(opts, :length, random_length_fn)
    chapters = Keyword.get(opts, :chapters, [])

    random_chapters =
      1..random_chapters_length
      |> Enum.to_list()
      |> Enum.map(fn _ -> manga_host(:chapter) end)
      |> Enum.flat_map(& &1.content)

    chapters_content = random_chapters ++ chapters

    content = [{"div", [{"class", "chapters"}], chapters_content}]
    length = Enum.count(random_chapters) + Enum.count(chapters)

    %{
      content: content,
      data: %{
        length: length
      }
    }
  end
end
