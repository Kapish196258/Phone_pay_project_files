import streamlit as st
import pandas as pd
import mysql.connector
import plotly.express as px
import os

# ------------------ 1. Connect to MySQL ------------------
@st.cache_resource
def connect_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="Kinkap@@1105",  # 🔐 Replace for security
        database="phonepe_data"
    )

# ------------------ 2. Query Functions ------------------
def get_top_states():
    query = """
        SELECT State, SUM(Transaction_Amount) AS Total_Amount
        FROM aggregated_transaction
        GROUP BY State
        ORDER BY Total_Amount DESC
        LIMIT 10;
    """
    return pd.read_sql(query, connect_db())

def get_top_brands():
    query = """
        SELECT Brand, SUM(Count) AS Total_Users
        FROM aggregated_user
        GROUP BY Brand
        ORDER BY Total_Users DESC
        LIMIT 10;
    """
    return pd.read_sql(query, connect_db())

def get_top_insurance_states():
    query = """
        SELECT State, SUM(Transaction_Amount) AS Insurance_Amount
        FROM aggregated_insurance
        GROUP BY State
        ORDER BY Insurance_Amount DESC
        LIMIT 10;
    """
    return pd.read_sql(query, connect_db())

def get_top_app_opens():
    query = """
        SELECT District, SUM(App_Opens) AS Total_App_Opens
        FROM map_user
        GROUP BY District
        ORDER BY Total_App_Opens DESC
        LIMIT 10;
    """
    return pd.read_sql(query, connect_db())

def get_top_txn_districts():
    query = """
        SELECT Entity_Name AS District, SUM(Transaction_Amount) AS Total_Amount
        FROM top_transaction
        WHERE Entity_Level = 'district'
        GROUP BY District
        ORDER BY Total_Amount DESC
        LIMIT 10;
    """
    return pd.read_sql(query, connect_db())

# ------------------ 3. Page Layout ------------------
st.set_page_config(page_title="📱 PhonePe Pulse Dashboard", layout="wide")
image_path = os.path.join("assets", "PhonePe-Logo.wine.png")
st.image(image_path, width=300)
st.title("PhonePe Pulse Dashboard")
st.caption("Built with MySQL, Python, and Streamlit . Styled to PhonePe's theme")
st.markdown("---")

# Sidebar Navigation
section = st.sidebar.radio("Select a Section", [
    "Top 10 States by Transaction Amount",
    "Top 10 Brands by User Count",
    "Top 10 States by Insurance",
    "Top 10 Districts by App Opens",
    "Top 10 Districts by Transaction"
])

st.markdown("### 📈 Visual Insights")
st.markdown("Each section presents a real-time visualization from PhonePe transaction data.")

# ------------------ 4. Visualization Logic ------------------

if section == "Top 10 States by Transaction Amount":
    st.subheader("🧾 Top 10 States by Transaction Amount")
    df = get_top_states()
    fig = px.bar(df, x='Total_Amount', y='State', orientation='h', color='Total_Amount',
                 color_continuous_scale='Purples', text_auto='.2s')
    st.plotly_chart(fig, use_container_width=True)
    st.markdown("🔍 **Insight:** Telangana, Karnataka, and Maharashtra lead in transaction volume, indicating high digital payment adoption in these regions.")
    st.divider()

elif section == "Top 10 Brands by User Count":
    st.subheader("📱 Most Used Mobile Brands by PhonePe Users")
    df = get_top_brands()
    fig = px.bar(df, x='Total_Users', y='Brand', orientation='h', color='Total_Users',
                 color_continuous_scale='Purples', text_auto='.2s')
    st.plotly_chart(fig, use_container_width=True)
    st.markdown("**Insight:** Xiaomi, Samsung, and Vivo dominate the user base. Most users access PhonePe via affordable Android smartphones.")
    st.divider()

elif section == "Top 10 States by Insurance":
    st.subheader("States with Highest Insurance Transaction Amount")
    df = get_top_insurance_states()
    fig = px.bar(df, x='Insurance_Amount', y='State', orientation='h', color='Insurance_Amount',
                 color_continuous_scale='Purples', text_auto='.2s')
    st.plotly_chart(fig, use_container_width=True)
    st.markdown("**Insight:** Karnataka and Maharashtra show a strong lead in digital insurance adoption, signaling mature fintech ecosystems.")
    st.divider()

elif section == "Top 10 Districts by App Opens":
    st.subheader("📲 App Opens: Top 10 Engaged Districts")
    df = get_top_app_opens()
    fig = px.bar(df, x='Total_App_Opens', y='District', orientation='h', color='Total_App_Opens',
                 color_continuous_scale='Purples', text_auto='.2s')
    st.plotly_chart(fig, use_container_width=True)
    st.markdown("🔍 **Insight:** Bengaluru Urban, Pune, and Ganganagar lead in app opens, indicating regular user engagement and app loyalty.")
    st.divider()

elif section == "Top 10 Districts by Transaction":
    st.subheader("🏙️ Districts with Highest Transaction Value")
    df = get_top_txn_districts()
    fig = px.bar(df, x='Total_Amount', y='District', orientation='h', color='Total_Amount',
                 color_continuous_scale='Purples', text_auto='.2s')
    st.plotly_chart(fig, use_container_width=True)
    st.markdown("🔍 **Insight:** Bengaluru Urban and Hyderabad dominate in value, making them strategic regions for product and partner expansion.")
    st.divider()
