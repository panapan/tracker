require 'open-uri'
http://[ems|usps|dhl|tnt|fedex|spsr].postabot.ru/[номер отправления]
xml=open("http://postabot.ru/tr/tracker2.php?track-number=11740378009514&carrier=ems").read
hash=Hash.from_xml(xml)
hash["response"]["track_number"]["items"]['item']['tracking']['track'].each {|e| puts e['event']}

 {"response"=>
  {"track_number"=>
    {"id"=>"11740378009514", "carrier"=>"EMS", "count"=>"1", "items"=>
      {"item"=>
        {"id"=>"1", "routeStartLoc"=>{"value"=>"Москва 403"}, "routeStartTime"=>{"value"=>"28/ 01/2015 09:16"}, "routeEndLoc"=>{"value"=>"Орел 42"}, "routeEndTime"=>{"value"=>"03/02/2015 17:54"}, "transitTime"=>{"value"=>""}, "signedFor"=>{"value"=>""}, "delivered"=>{"value"=>"yes"}, "tracking"=>
          {"track"=>
            [{"id"=>"0", "date"=>"28/01/2015", "time"=>"09:16", "geo"=>"Москва 403, 117403", "event"=>"Приём. Единичный"}, 
            {"id"=>"1", "date"=>"28/01/2015", "time"=>"09:16", "geo"=>"Москва 403, 117403", "event"=>"Обработка. Покинуло место приёма"}, 
            {"id"=>"2", "date"=>"29/01/2015", "time"=>"02:59", "geo"=>"Москва МСП-3 цех-3 Мпко-Юг, 111976", "event"=>"Обработка. Покинуло сортировочный центр"}, 
            {"id"=>"3", "date"=>"29/01/2015", "time"=>"03:55", "geo"=>"Московский Асц цех Посылок, 140983", "event"=>"Обработка. Сортировка"}, 
            {"id"=>"4", "date"=>"29/01/2015", "time"=>"11:07", "geo"=>"Московский Асц цех Логистики, 140980", "event"=>"Обработка. Покинуло сортировочный центр"}, 
            {"id"=>"5", "date"=>"29/01/2015", "time"=>"21:18", "geo"=>"Москва-Павелецкий вокзал ПЖДП цех- 1, 102152", "event"=>"Обработка. Покинуло сортировочный центр"}, 
            {"id"=>"6", "date"=>"31/01/2015", "time"=>"15:55", "geo"=>"Орел МСЦ, 302960", "event"=>"Обработка. Покинуло сортировочный центр"}, 
            {"id"=>"7", "date"=>"31/01/2015", "time"=>"16:49", "geo"=>"Орел 42, 302042", "event"=>"Обработка. Прибыло в место вручения"}, 
            {"id"=>"8", "date"=>"31/01/2015", "time"=>"16:50", "geo"=>"Орел 42, 302042", "event"=>"Неудачная попытка вручения. Адресат заберет отправление сам"}, 
            {"id"=>"9", "date"=>"03/02/2015", "time"=>"17:54", "geo"=>"Орел 42, 302042", "event"=>"Вручение. Вручение адресату"}
            ]
          }
        }
      }
    }
  }
}

выкинул из _parsel_inner:

      <ul>
        <li> Отправитель: <%= parcel.from_loc %>, 
          отправлено: <%= parcel.from_time.strftime('%d.%m.%y %H:%M') unless parcel.from_time.nil? %></li>
        <li> Получатель: <%= parcel.to_loc %>, доставлено:
          <%= parcel.delivered? ? parcel.to_time.strftime('%d.%m.%y %H:%M') : 'еще нет' %></li>
        <li> Служба доставки: <%= parcel.carrier %> </li>
        <li> Добавлено <%= time_ago_in_words(parcel.created_at) 
          %> назад. </ul>
      </ul>

        <thead> <tr>
          <th> Дата </th>
          <th> Место </th>
          <th> Событие </th>
        </tr> </thead>

      <%= link_to "развернуть", "#collapse#{parcel.id}", 
      {"data-target" => "#collapse#{parcel.id}", "data-toggle" => "collapse", class: "collapsed"}  %>

          <% @first = true %>
          <%= render parcel.tracks %>
          <%= tag('/div', nil, true) unless @first %>

_track:

<% if @first then %>
  </table>
  <%= tag("div", {id: "collapse#{track.parcel.id}", class: "panel-collapse collapse"}, true)  %>
  <% @first = false %>
  <table class="table table-condensed">
<% end %>
