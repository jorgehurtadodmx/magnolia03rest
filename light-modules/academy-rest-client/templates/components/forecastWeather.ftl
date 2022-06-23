
<div>

${ctx.response.setHeader("Cache-Control", "no-cache")}

[#assign customValues = {"location": ctx.tourSelected.location!"London", "temperatureUnit": content.units!"metric"} /]
[#assign forecast = restfn.call("weather", "forecastCityName", customValues)]

  <div id="respTable">
    <div id="resp-table-body">

      <div class="resp-table-row">
        [#if forecast.list?has_content]
          [#list forecast.list.elements() as day]
            <div class="table-body-cell">
            [#if (day?index?number %4) == 0]
              <div class="table-body-cell">
                ${(((day.dt?number)*1000)?number_to_date)?string["EEE, dd/MM"]}
              </div>
              <div class="table-body-cell hour">
                ${(((day.dt?number)*1000)?number_to_date)?string["HH:mm a"]}
              </div>
              [#list day.weather.elements() as weatherItem]
                <br>
                <div class="table-body-cell">
                  <i class="iconWeather owi owi-${weatherItem.icon.textValue()}"></i>
                </div>

              [/#list]
              <div class="table-body-cell temperature">
                ${day.main.temp_max?number?string["0"]}[#if content.units=="imperial"]°F[#else]°C[/#if]
              </div>

            [/#if]
            </div>
          [/#list]
        [#elseif forecast.message?has_content]
          <div class="weatherError">
            <ul>
              <li>city:${ctx.tourSelected.location!"No city selected"}</li>
              <li>message:${forecast.message!"No message"}</li>
            </ul>
          </div>
        [/#if]
      </div>
    </div>

  </div>
</div>