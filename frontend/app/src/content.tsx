import type { ReactNode as N } from "react";

export default {
  // Top bar and other places
  appName: "Liquity v2",

  // Menu bar
  menu: {
    borrow: "Borrow",
    leverage: "Leverage",
    earn: "Earn",
    stake: "Stake",
  },

  // Earn home screen: header
  earnHome: {
    headline: (tokensIcons: N, boldIcon: N) => (
      <>
        Earn {tokensIcons} with {boldIcon} BOLD
      </>
    ),
    subheading: "Get BOLD and extra ETH rewards from liquidations",
    poolsColumns: {
      pool: "Pool",
      apy: "APY",
      myDepositAndRewards: "My Deposits and Rewards",
    },
  },

  // Earn screen
  earnScreen: {
    backButton: "See all pools",
    headerPool: (pool: N) => <>{pool} pool</>,
    headerTvl: (tvl: N) => (
      <>
        <abbr title="Total Value Locked">TVL</abbr> {tvl}
      </>
    ),
    headerApy: () => (
      <>
        Current <abbr title="Annual percentage yield">APY</abbr>
      </>
    ),
    accountPosition: {
      depositLabel: "My deposit",
      rewardsLabel: "My rewards",
    },
    tabs: {
      deposit: "Deposit",
      withdraw: "Withdraw",
      claim: "Claim rewards",
    },
    depositPanel: {
      label: "You deposit",
      shareLabel: (share: N) => (
        <>
          Share in the pool {share}
        </>
      ),
      claimCheckbox: "Also claim rewards",
    },
    withdrawPanel: {
      label: "You withdraw",
      claimCheckbox: "Also claim rewards",
    },
    rewardsPanel: {
      label: "You claim",
      details: (usdAmount: N, fee: N) => (
        <>
          ~{usdAmount} USD • Expected gas fee ~{fee} USD
        </>
      ),
    },
  },
};
