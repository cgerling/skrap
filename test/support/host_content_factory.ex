defmodule Skrap.Factory.HostContent do
  alias Faker.{Internet, Person, Superhero}

  def manga_host(:manga, opts \\ []) do
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
end
