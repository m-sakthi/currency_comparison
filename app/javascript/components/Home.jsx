import React, { useState, useEffect } from "react";
import ReactHighstock from "react-highcharts/ReactHighstock.src";

const Home = () => {
  const [chartConfig, setChartConfig] = useState({});
  const [loading, setLoading] = useState(true);
  const [currency, setCurrency] = useState("USD");

  useEffect(() => {
    const url = `/api/compare_currency?to_currency=${currency}`;
    fetch(url)
      .then((response) => {
        if (response.ok) {
          return response.json();
        }

        throw new Error("Network response was not ok.");
      })
      .then((response) => {
        const config = {
          title: {
            text: `BRL-${currency} Comparison`,
          },
          series: [
            {
              name: currency,
              data: response.results.rates,
              tooltip: {
                valueDecimals: 4,
              },
            },
          ],
        };
        setChartConfig(config);
        setLoading(false);
      })
      .catch((e) => {
        console.log("An error occurred while fetching the data.");
      });
  }, [currency]);

  return (
    <div>
      {loading ? (
        "Hang tight while we are fetching the data for you..!!"
      ) : (
        <>
          <ReactHighstock config={chartConfig} />
          {["AUD", "EUR", "USD"].map((c) => (
            <button key={c} onClick={() => setCurrency(c)}>
              {c}
            </button>
          ))}
        </>
      )}
    </div>
  );
};

export default Home;
